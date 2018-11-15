//
//  HomeViewBuilder.swift
//  viper_basic_slider
//
//  Created by Alexander Kolovatov on 15/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

// View
protocol HomeView: class {
    
}

// Interactor
protocol HomeUseCase: class {
    
}

class HomeInteractor: HomeUseCase {
    
}

// Presenter
protocol HomeViewPresentation: class {
    var view: HomeView? { get }
    var router: HomeViewWireFrame? { get }
    var interactor: HomeUseCase? { get }
}

class HomeViewPresenter: HomeViewPresentation {
    weak var view: HomeView?
    var router: HomeViewWireFrame?
    var interactor: HomeUseCase?
}

// Router
protocol HomeViewWireFrame: class {
    var viewController: UIViewController? { get }
}

class HomeViewRouter: HomeViewWireFrame {
    var viewController: UIViewController?
}


class HomeViewBuilder {
    
    static func assembleModule() -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController
        let presenter = HomeViewPresenter()
        let interactor = HomeInteractor()
        let router = HomeViewRouter()
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
}
