//
//  MainViewController.swift
//  Color Picker
//
//  Created by Steven Kirke on 06.09.2020.
//  Copyright © 2020 Steven Kirke. All rights reserved.
//

import UIKit

protocol updateBackground : class {
    func update(color: [Float])
}

class MainViewController: UIViewController {

    
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingViewController {
            settingVC.updateRGB = self

        }
    }
}

extension MainViewController: updateBackground {
    func update(color: [Float]) {
              backgroundView.backgroundColor = UIColor(
              displayP3Red: CGFloat(color[0]),
              green: CGFloat(color[1]),
              blue: CGFloat(color[2]),
              alpha: 1)
    }
    
}
