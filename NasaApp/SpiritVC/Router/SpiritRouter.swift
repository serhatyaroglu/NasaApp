//
//  SpiritRouter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 16.02.2022.
//

import Foundation
class SpiritRouter : PresenterToRouterSpiritProtocol {
    static func createModule(ref: SpiritVC) {
        let presenter : ViewToPresenterSpiritProtocol & InteractorToPresenterSpiritProtocol = SpiritPresenter()
        //View controller için
        ref.SpiritPresenterNesnesi = presenter
        //Presenter için
        ref.SpiritPresenterNesnesi?.SpiritInteractor = SpiritInteractor()
        ref.SpiritPresenterNesnesi?.SpiritView = ref
        //Interactor için
        ref.SpiritPresenterNesnesi?.SpiritInteractor?.SpiritPresenter = presenter
    }
}

