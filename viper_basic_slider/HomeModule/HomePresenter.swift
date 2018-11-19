//
//  HomePresenter.swift
//  viper_basic_slider
//
//  Created by  Alex Kolovatov on 19/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

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
                guard let view = self.view else { return }
                view.loadCurrentColor(rgb: currentRGB)
            }
        }
        
    }
    
    /// When color value changes in view controller it delegates work to presenter
    func onColorValueChange(rgb: (CGFloat, CGFloat, CGFloat)) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let `self` = self else { return }
            guard let interactor = self.interactor else { return }
            
            interactor.saveCurrentColor(rgb: rgb)
        }
        
    }
    
}
