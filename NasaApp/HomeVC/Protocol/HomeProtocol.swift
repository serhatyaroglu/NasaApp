//
//  HomeProtocol.swift
//  NasaApp
//
//  Created by serhat yaroglu on 12.02.2022.
//

import Foundation

protocol ViewToPresenterHomeProtocol {
    var HomeInteractor:PresenterToInteractorHomeProtocol? {get set}
    var HomeView:PresenterToViewHomeProtocol? {get set}
    
    func NasaAllPhotosDownload(cameraList:String)
}


protocol PresenterToInteractorHomeProtocol {
    var HomePresenter:InteractorToPresenterHomeProtocol? {get set}
    
    func NasaAllPhotoGet(cameraList:String)
}
protocol InteractorToPresenterHomeProtocol {
    func presenteraVeriGonder(roverPhotoList:Array<Photo>)
}

protocol PresenterToViewHomeProtocol {
    func vieweVeriGonder(roverPhotoList:Array<Photo>)
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref:HomeVC)
}
