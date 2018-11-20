//
//  ViewController.swift
//  viper_basic_slider
//
//  Created by Alexander Kolovatov on 15/11/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func loadCurrentColor(rgb: (CGFloat, CGFloat, CGFloat))
}

protocol ColorValueDelegate {
    func colorValueChange()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var rgbText: UILabel!
    
    var presenter: HomeViewPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadCurrentColor()
    }

    @IBAction func handleRedSlider(_ sender: UISlider) {
        colorValueChange()
    }
    
    @IBAction func handleGreenSlider(_ sender: UISlider) {
        colorValueChange()
    }
    
    @IBAction func handleBlueSlider(_ sender: UISlider) {
        colorValueChange()
    }
    
    @IBAction func hanleShowAnotherController(_ sender: UIButton) {
        guard let presenter = presenter else { return }
        presenter.showAnotherViewControllerPressed()
    }
    /// RGB values to be saved. Values passed should be between 0-255.
    ///
    /// - Parameter rgb: RGB
    func saveCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) {
        guard let presenter = presenter else { return }
        presenter.onColorValueChange(rgb: rgb)
    }
    
    func loadCurrentColor()  {
        guard let presenter = presenter else { return }
        presenter.onLoadCurrentColor()
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let presenter = presenter else { return }
        guard let router = presenter.router else { return }
        router.prepare(for: segue, sender: sender)
    }
    
}

// MARK: - HomeView Protocol

extension HomeViewController: HomeView {
    
    func loadCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) {
        redSlider.setValue(Float(rgb.0), animated: false)
        greenSlider.setValue(Float(rgb.1), animated: false)
        blueSlider.setValue(Float(rgb.2), animated: false)
        view.backgroundColor = UIColor.init(displayP3Red: rgb.0/255, green: rgb.1/255, blue: rgb.2/255, alpha: 1)
        rgbText.text = "R(\(rgb.0)), G(\(rgb.1)), B(\(rgb.2))"
        rgbText.textColor = UIColor.init(displayP3Red: rgb.1/255, green: rgb.2/255, blue: rgb.0/255, alpha: 1)
    }
    
}

// MARK: - ColorValueDelegate

extension HomeViewController: ColorValueDelegate {
    
    /// Track color value changes
    func colorValueChange() {
        let step: Float = 1
        let red = CGFloat(round(redSlider.value / step) * step)
        let green = CGFloat(round(greenSlider.value / step) * step)
        let blue = CGFloat(round(blueSlider.value / step) * step)
        
        rgbText.text = "R(\(red)), G(\(green)), B(\(blue))"
     
        view.backgroundColor = UIColor.init(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
        rgbText.textColor = UIColor.init(displayP3Red: green/255, green: blue/255, blue: red/255, alpha: 1)
        
        saveCurrentColor(rgb: (red, green, blue))
    }
    
}

