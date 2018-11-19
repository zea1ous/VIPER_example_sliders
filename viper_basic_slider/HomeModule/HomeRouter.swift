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
    var viewController: UIViewController? { get }
}

class HomeViewRouter: HomeViewWireFrame {
    var viewController: UIViewController?
}
