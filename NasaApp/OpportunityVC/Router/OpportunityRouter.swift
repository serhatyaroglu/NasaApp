//
//  OpportunityRouter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import Foundation

class OpportunityRouter : PresenterToRouterOpportunityProtocol {
    static func createModule(ref: OpportunityVC) {
        let presenter : ViewToPresenterOpportunityProtocol & InteractorToPresenterOpportunityProtocol = OpportunityPresenter()
        //View controller için
        ref.OpportunityPresenterNesnesi = presenter
        //Presenter için
        ref.OpportunityPresenterNesnesi?.OpportunityInteractor = OpportunityInteractor()
        ref.OpportunityPresenterNesnesi?.OpportunityView = ref
        //Interactor için
        ref.OpportunityPresenterNesnesi?.OpportunityInteractor?.OpportunityPresenter = presenter
    }
}

