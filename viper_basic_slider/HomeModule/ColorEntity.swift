//
//  ColorEntity.swift
//  viper_basic_slider
//
//  Created by Alexander Kolovatov on 15/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class ColorEntity {
    
    func save(rgb: (CGFloat, CGFloat, CGFloat)) {
        UserDefaults.standard.set(rgb.0, forKey: "red")
        UserDefaults.standard.set(rgb.1, forKey: "green")
        UserDefaults.standard.set(rgb.2, forKey: "blue")
    }
    
    func fetch() -> (CGFloat, CGFloat, CGFloat) {
        return  (CGFloat(UserDefaults.standard.float(forKey: "red")), CGFloat(UserDefaults.standard.float(forKey: "green")), CGFloat(UserDefaults.standard.float(forKey: "blue")))
    }
    
}
