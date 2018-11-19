//
//  HomeInteractor.swift
//  viper_basic_slider
//
//  Created by  Alex Kolovatov on 19/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

// Interactor
protocol HomeUseCase: class {
    func loadCurrentColor() -> (CGFloat, CGFloat, CGFloat)
    func saveCurrentColor(rgb: (CGFloat, CGFloat, CGFloat))
}

class HomeInteractor: HomeUseCase {
    
    var colorEntityObject: ColorEntity?
    
    // Dependency injection
    init(dataObject: ColorEntity = ColorEntity()) {
        colorEntityObject = dataObject
    }
    
    /// Load current color use case handled here
    ///
    /// - Returns: (CGFloat, CGFloat, CGFloat)
    func loadCurrentColor() -> (CGFloat, CGFloat, CGFloat) {
        guard let currentRgb = colorEntityObject?.fetch() else { return (0, 0, 0) }
        return currentRgb
    }
    
    /// Save current color use case handled here
    ///
    /// - Parameter rgb: (CGFloat, CGFloat, CGFloat) between 0-255
    func saveCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) {
        guard let colorEntityObject = colorEntityObject else { return }
        colorEntityObject.save(rgb: rgb)
    }
    
}
