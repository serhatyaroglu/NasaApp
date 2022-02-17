//
//  OpportunityPresenter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import Foundation

class OpportunityPresenter : ViewToPresenterOpportunityProtocol {
    var OpportunityInteractor: PresenterToInteractorOpportunityProtocol?
    var OpportunityView: PresenterToViewOpportunityProtocol?
    func NasaAllPhotosDownload(cameraList:String) {
        OpportunityInteractor?.NasaAllPhotoGet(cameraList:cameraList)

    }
}
extension OpportunityPresenter : InteractorToPresenterOpportunityProtocol {
    func presenteraVeriGonder(opportunityPhotoList: Array<Photo>) {
        OpportunityView?.vieweVeriGonder(opportunityPhotoList: opportunityPhotoList)
    }
}
