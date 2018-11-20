//
//  HomeRouter.swift
//  viper_basic_slider
//
//  Created by  Alex Kolovatov on 19/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

// Router
protocol HomeViewWireFrame: class {
    func showAnotherModule()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class HomeViewRouter: HomeViewWireFrame {
    
    weak var viewController: HomeViewController!
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func showAnotherModule() {
        viewController.performSegue(withIdentifier: "anotherSegue", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
