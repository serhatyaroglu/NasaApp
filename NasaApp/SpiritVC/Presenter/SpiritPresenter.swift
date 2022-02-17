//
//  SpiritPresenter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//




import Foundation

class SpiritPresenter : ViewToPresenterSpiritProtocol {
    var SpiritInteractor: PresenterToInteractorSpiritProtocol?
    var SpiritView: PresenterToViewSpiritProtocol?
    func NasaAllPhotosDownload(cameraList:String) {
        SpiritInteractor?.NasaAllPhotoGet(cameraList:cameraList)

    }
}
extension SpiritPresenter : InteractorToPresenterSpiritProtocol {
    func presenteraVeriGonder(spiritPhotoList: Array<Photo>) {
        SpiritView?.vieweVeriGonder(spiritPhotoList: spiritPhotoList)
    }
}
