//
//  AnotherViewController.swift
//  viper_basic_slider
//
//  Created by  Alex Kolovatov on 19/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }

    @IBAction func handleClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
