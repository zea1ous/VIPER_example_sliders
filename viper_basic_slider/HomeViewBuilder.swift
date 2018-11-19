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
    func loadCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) 
}

// Interactor
protocol HomeUseCase: class {
    func loadCurrentColor() -> (CGFloat, CGFloat, CGFloat)
    func saveCurrentColor(rgb: (CGFloat, CGFloat, CGFloat))
}

class HomeInteractor: HomeUseCase {
    
    var appColorDataObject: AppColorDataObject?
    
    // Dependency injection
    init(dataObject: AppColorDataObject = AppColorDataObject()) {
        appColorDataObject = dataObject
    }

    /// Load current color use case handled here
    ///
    /// - Returns: (CGFloat, CGFloat, CGFloat)
    func loadCurrentColor() -> (CGFloat, CGFloat, CGFloat) {
        guard let currentRgb = appColorDataObject?.fetch() else { return (0, 0, 0) }
        return currentRgb
    }
    
    /// Save current color use case handled here
    ///
    /// - Parameter rgb: (CGFloat, CGFloat, CGFloat) between 0-255
    func saveCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) {
        appColorDataObject?.save(rgb: rgb)
    }
    
}

// Presenter
protocol HomeViewPresentation: class {
    var view: HomeView? { get }
    var router: HomeViewWireFrame? { get }
    var interactor: HomeUseCase? { get }
    
    func onLoadCurrentColor()
    func onColorValueChange(rgb: (CGFloat, CGFloat, CGFloat))
}

class HomeViewPresenter: HomeViewPresentation {
    
    weak var view: HomeView?
    var router: HomeViewWireFrame?
    var interactor: HomeUseCase?
    
    /// Load current color received from view controller.
    func onLoadCurrentColor() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let `self` = self else { return }
            
            guard let currentRGB = self.interactor?.loadCurrentColor() else { return }
            
            DispatchQueue.main.async {
                self.view?.loadCurrentColor(rgb: currentRGB)
            }
        }
    
    }
    
    
    /// When color value changes in view controller it delegates work to presenter
    func onColorValueChange(rgb: (CGFloat, CGFloat, CGFloat)) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let `self` = self else { return }
            
            self.interactor?.saveCurrentColor(rgb: rgb)
        }
        
    }
    
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
