//
//  HomePresenter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 12.02.2022.
//


import Foundation

class HomePresenter : ViewToPresenterHomeProtocol {
    var HomeInteractor: PresenterToInteractorHomeProtocol?
    var HomeView: PresenterToViewHomeProtocol?
    func NasaAllPhotosDownload(cameraList:String) {
        HomeInteractor?.NasaAllPhotoGet(cameraList:cameraList)

    }
}
extension HomePresenter : InteractorToPresenterHomeProtocol {
    func presenteraVeriGonder(roverPhotoList: Array<Photo>) {
           HomeView?.vieweVeriGonder(roverPhotoList: roverPhotoList)
    }
}
