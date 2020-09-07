//
//  Styles.swift
//  Color Picker
//
//  Created by Steven Kirke on 06.09.2020.
//  Copyright © 2020 Steven Kirke. All rights reserved.
//

import UIKit


class Styles {
    
    func blurImage(view: UIImageView, style: UIBlurEffect.Style) {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurView.frame = view.frame
        view.addSubview(blurView)
    }

}
