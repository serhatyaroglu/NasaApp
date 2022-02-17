//
//  HomeRouter.swift
//  NasaApp
//
//  Created by serhat yaroglu on 12.02.2022.
//

import Foundation
class HomeRouter : PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeVC) {
        let presenter : ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        //View controller için
        ref.HomePresenterNesnesi = presenter
        //Presenter için
        ref.HomePresenterNesnesi?.HomeInteractor = HomeInteractor()
        ref.HomePresenterNesnesi?.HomeView = ref
        //Interactor için
        ref.HomePresenterNesnesi?.HomeInteractor?.HomePresenter = presenter
    }
}
