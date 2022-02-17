//
//  OpportunityVC.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import UIKit
import Kingfisher
class OpportunityVC: UIViewController {
    @IBOutlet weak var oppornutiyPickerView: UIButton!
    
    @IBOutlet weak var OpportunityCollectionView: UICollectionView!
    var OpportunityPresenterNesnesi:ViewToPresenterOpportunityProtocol?
    var opportunityPhotoList = [Photo]()
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    let cameraNameList = ["NAVCAM","PANCAM"]
    override func viewDidLoad() {
        super.viewDidLoad()
        OpportunityCollectionView.delegate = self
        OpportunityCollectionView.dataSource = self
        OpportunityRouter.createModule(ref: self)
        OpportunityPresenterNesnesi?.NasaAllPhotosDownload(cameraList: "")
        // Do any additional setup after loading the view.
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
        
        let alert = UIAlertController(title: "Select Select Camera", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = oppornutiyPickerView
        alert.popoverPresentationController?.sourceRect = oppornutiyPickerView.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
    alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.cameraNameList)[self.selectedRow]
            let name = selected
            self.oppornutiyPickerView.setTitle(name, for: .normal)
            OpportunityPresenterNesnesi?.OpportunityInteractor?.NasaAllPhotoGet(cameraList: "&camera=\(name)" )

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        OpportunityPresenterNesnesi?.OpportunityInteractor?.NasaAllPhotoGet(cameraList: "")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPopUp"{
            let opportunityPhoto = sender as? Photo
            let toVC = segue.destination as! PopUpVC
            toVC.photoPopUp = opportunityPhoto
        }
    }
}
extension OpportunityVC :UIPickerViewDelegate,UIPickerViewDataSource{
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
extension OpportunityVC : PresenterToViewOpportunityProtocol {
    func vieweVeriGonder(opportunityPhotoList: Array<Photo>) {
        self.opportunityPhotoList = opportunityPhotoList
        DispatchQueue.main.async {
            self.OpportunityCollectionView.reloadData()
        }
    }
}
extension OpportunityVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let opportunity = opportunityPhotoList[indexPath.row]
        performSegue(withIdentifier: "ToPopUp", sender: opportunity)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return opportunityPhotoList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let opportunity = opportunityPhotoList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpportunityCell", for: indexPath) as! OpportunityCollectionViewCell
        cell.nameLabel.text = opportunity.camera?.name
        
       cell.image.kf.setImage(with: URL(string: opportunity.imgSrc!))
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.borderWidth = 1
       
        return cell
    }
    
    
}

