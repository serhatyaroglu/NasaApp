//
//  SpiritProtocol.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import Foundation


protocol ViewToPresenterSpiritProtocol {
    var SpiritInteractor:PresenterToInteractorSpiritProtocol? {get set}
    var SpiritView:PresenterToViewSpiritProtocol? {get set}
    
    func NasaAllPhotosDownload(cameraList:String)
}


protocol PresenterToInteractorSpiritProtocol {
    var SpiritPresenter:InteractorToPresenterSpiritProtocol? {get set}
    
    func NasaAllPhotoGet(cameraList:String)
}
protocol InteractorToPresenterSpiritProtocol {
    func presenteraVeriGonder(spiritPhotoList:Array<Photo>)
}

protocol PresenterToViewSpiritProtocol {
    func vieweVeriGonder(spiritPhotoList:Array<Photo>)
}

protocol PresenterToRouterSpiritProtocol {
    static func createModule(ref:SpiritVC)
}
