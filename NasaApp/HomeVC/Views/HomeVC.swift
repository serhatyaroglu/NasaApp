//
//  ViewController.swift
//  NasaApp
//
//  Created by serhat yaroglu on 11.02.2022.
//
import UIKit
import Kingfisher
class HomeVC: UIViewController {
    @IBOutlet weak var cameraPickerView: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    var HomePresenterNesnesi:ViewToPresenterHomeProtocol?
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    let cameraNameList = ["FHAZ","RHAZ","MAST"]
    var roverPhotoList = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        HomeRouter.createModule(ref: self)
        HomePresenterNesnesi?.NasaAllPhotosDownload(cameraList: "")
        CollectionView.showsVerticalScrollIndicator = false
        CollectionView.backgroundColor = .clear
 
    }
    @IBAction func PickerViewButton(_ sender: Any) {
        
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
            pickerView.dataSource = self
            pickerView.delegate = self
            
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            vc.view.addSubview(pickerView)
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
            
            let alert = UIAlertController(title: "Select Camera", message: "", preferredStyle: .actionSheet)
            
            alert.popoverPresentationController?.sourceView = cameraPickerView
            alert.popoverPresentationController?.sourceRect = cameraPickerView.bounds
            
            alert.setValue(vc, forKey: "contentViewController")
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            }))
            
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
                self.selectedRow = pickerView.selectedRow(inComponent: 0)
                let selected = Array(self.cameraNameList)[self.selectedRow]
                let name = selected
                self.cameraPickerView.setTitle(name, for: .normal)
                HomePresenterNesnesi?.HomeInteractor?.NasaAllPhotoGet(cameraList: "&camera=\(name)" )

            }))
            
            self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        HomePresenterNesnesi?.HomeInteractor?.NasaAllPhotoGet(cameraList: "")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPopUp"{
            let roverPhoto = sender as? Photo
            let toVC = segue.destination as! PopUpVC
            toVC.photoPopUp = roverPhoto
        }
    }
}
extension HomeVC :UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cameraNameList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cameraNameList[row]
    }
    
    
}
extension HomeVC : PresenterToViewHomeProtocol {
    func vieweVeriGonder(roverPhotoList: Array<Photo>) {
        self.roverPhotoList = roverPhotoList
      //  self.filteredPhotoList = roverPhotoList
        DispatchQueue.main.async {
            self.CollectionView.reloadData()
        }
    }
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let rover = roverPhotoList[indexPath.row]
          performSegue(withIdentifier: "ToPopUp", sender: rover)
          collectionView.deselectItem(at: indexPath, animated: true)
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverPhotoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rover = roverPhotoList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.NameLabel.text = rover.camera?.name
        
       cell.image.kf.setImage(with: URL(string: rover.imgSrc!))
//        print("gelen veriler burada \(String(describing: Nasa.camera?.fullName))")
      //  cell.image.image = UIImage(named: "\(Nasa)")
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
    
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.borderWidth = 1
       
        return cell
    }
  


}
