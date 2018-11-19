//
//  HomeAssembly.swift
//  viper_basic_slider
//
//  Created by Alexander Kolovatov on 15/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class HomeAssembly {
    
    static func assembleModule() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let presenter = HomeViewPresenter()
        let interactor = HomeInteractor()
        let router = HomeViewRouter()
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController else {
            return nil
        }
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
}
