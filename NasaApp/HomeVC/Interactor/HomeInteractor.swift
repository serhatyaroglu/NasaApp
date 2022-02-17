//
//  HomeInteractor.swift
//  NasaApp
//
//  Created by serhat yaroglu on 12.02.2022.
//

import Foundation
import Alamofire
class HomeInteractor : PresenterToInteractorHomeProtocol {
    var HomePresenter: InteractorToPresenterHomeProtocol?

    func NasaAllPhotoGet(cameraList:String) {
        AF.request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000\(cameraList)&api_key=GPYkghROE7vxo8FDK7l7kFhBylqWoIMMRgMmzvXC&page=0",method: .get).responseJSON{ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(NasaPhoto.self, from: data)
                    var liste = [Photo]()
                    if let responseData = response.photos{
                        liste = responseData
                        for i in liste{
                           print("nasa camera \(i.camera!.name)")

                        }
                   
                    }
                        self.HomePresenter?.presenteraVeriGonder(roverPhotoList: liste)
                  
                }catch{
                    print("hata mesaji\(error.localizedDescription)")
                }
            }
        }
    }
}
