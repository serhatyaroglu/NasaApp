//
//  OpportunityProtocol.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import Foundation

protocol ViewToPresenterOpportunityProtocol {
    var OpportunityInteractor:PresenterToInteractorOpportunityProtocol? {get set}
    var OpportunityView:PresenterToViewOpportunityProtocol? {get set}
    
    func NasaAllPhotosDownload(cameraList:String)
}


protocol PresenterToInteractorOpportunityProtocol {
    var OpportunityPresenter:InteractorToPresenterOpportunityProtocol? {get set}
    
    func NasaAllPhotoGet(cameraList:String)
}
protocol InteractorToPresenterOpportunityProtocol {
    func presenteraVeriGonder(opportunityPhotoList:Array<Photo>)
}

protocol PresenterToViewOpportunityProtocol {
    func vieweVeriGonder(opportunityPhotoList:Array<Photo>)
}

protocol PresenterToRouterOpportunityProtocol {
    static func createModule(ref:OpportunityVC)
}
