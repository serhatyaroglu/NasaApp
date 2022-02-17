//
//  PopUpVC.swift
//  NasaApp
//
//  Created by serhat yaroglu on 17.02.2022.
//

import UIKit

class PopUpVC: UIViewController {
    var photoPopUp:Photo?

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var roverNameLabel: UILabel!
    @IBOutlet weak var photoDateLabel: UILabel!
    @IBOutlet weak var viewDesing: UIView!
    @IBOutlet weak var landingDateLabel: UILabel!
    @IBOutlet weak var roverImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        allDataConfirm()
    }
    
    func configureView(){
        viewDesing.layer.cornerRadius = 22
        viewDesing.clipsToBounds = true
        viewDesing.layer.borderWidth = 1
        viewDesing.layer.borderColor = UIColor.black.cgColor
    }
    func allDataConfirm(){
        if let roverDetail = photoPopUp{
            photoDateLabel.text = roverDetail.earthDate
            statusLabel.text = roverDetail.rover?.status
            cameraLabel.text = roverDetail.camera?.name
            launchDateLabel.text = roverDetail.rover?.launchDate
            roverNameLabel.text = roverDetail.rover?.name
            landingDateLabel.text = roverDetail.rover?.launchDate
            roverImage.kf.setImage(with: URL(string: roverDetail.imgSrc!))
            
        }
    }

}
