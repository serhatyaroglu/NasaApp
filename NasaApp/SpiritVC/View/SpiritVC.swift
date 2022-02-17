//
//  SpiritVC.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import UIKit

class SpiritVC: UIViewController {
    @IBOutlet weak var spiritPickerView: UIButton!
    var SpiritPresenterNesnesi:ViewToPresenterSpiritProtocol?
    var spiritPhotoList = [Photo]()
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    let cameraNameList = ["PANCAM","NAVCAM"]
    @IBOutlet weak var SpiritCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SpiritCollectionView.dataSource = self
        SpiritCollectionView.delegate = self
        SpiritRouter.createModule(ref: self)
       // SpiritPresenterNesnesi?.NasaAllPhotosDownload()
        // Do any additional setup after loading the view.
      
        SpiritCollectionView.showsVerticalScrollIndicator = false
        SpiritCollectionView.backgroundColor = .clear
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
        
        let alert = UIAlertController(title: "Select Background Colour", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = spiritPickerView
        alert.popoverPresentationController?.sourceRect = spiritPickerView.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
    alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.cameraNameList)[self.selectedRow]
            let spiritCameraName = selected
            self.spiritPickerView.setTitle(spiritCameraName, for: .normal)
            SpiritPresenterNesnesi?.SpiritInteractor?.NasaAllPhotoGet(cameraList: spiritCameraName )

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        SpiritPresenterNesnesi?.SpiritInteractor?.NasaAllPhotoGet(cameraList: "")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPopUp"{
            let spiritPhoto = sender as? Photo
            let toVC = segue.destination as! PopUpVC
            toVC.photoPopUp = spiritPhoto
        }
    }

   
}

extension SpiritVC :UIPickerViewDelegate,UIPickerViewDataSource{
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
extension SpiritVC : PresenterToViewSpiritProtocol {
    func vieweVeriGonder(spiritPhotoList: Array<Photo>) {
        self.spiritPhotoList = spiritPhotoList
      //  self.filteredPhotoList = roverPhotoList
        DispatchQueue.main.async {
            self.SpiritCollectionView.reloadData()
        }
    }
}
extension SpiritVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let spirit = spiritPhotoList[indexPath.row]
        performSegue(withIdentifier: "ToPopUp", sender: spirit)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spiritPhotoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let spirit = spiritPhotoList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpiritCell", for: indexPath) as! SpiritCollectionViewCell
        cell.nameLabel.text = spirit.camera?.name
        
       cell.image.kf.setImage(with: URL(string: spirit.imgSrc!))
//        print("gelen veriler burada \(String(describing: Nasa.camera?.fullName))")
      //  cell.image.image = UIImage(named: "\(Nasa)")
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
    
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.borderWidth = 1
       
        return cell
    }
    
    
}
