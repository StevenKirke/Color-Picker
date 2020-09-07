//
//  SettingViewController.swift
//  Color Picker
//
//  Created by Steven Kirke on 06.09.2020.
//  Copyright © 2020 Steven Kirke. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController, UITextFieldDelegate {
    
    private let style = Styles()
    
    private var colors:[Float] = [0.0, 0.0, 0.0]
    
    weak var updateRGB: updateBackground?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var colorIndicatorLabels: [UILabel]!
    
    @IBOutlet var colorSliders: [UISlider]!
    
    
    @IBOutlet weak var redField: UITextField!
    
    @IBOutlet weak var greenField: UITextField!
    
    @IBOutlet weak var blueField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redField.delegate = self
        greenField.delegate = self
        blueField.delegate = self
        
        style.blurImage(view: backgroundImage, style: .light)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }
    
    @IBAction func changeRedSlider(_ sender: Any) {
        changeColor(sender: colorSliders)
    }
    
    @IBAction func changeGreenSlider(_ sender: Any) {
       changeColor(sender: colorSliders)
    }
    
    @IBAction func changeBlueSlider(_ sender: Any) {
       changeColor(sender: colorSliders)
    }
    
    @IBAction func inputRedAction(_ sender: Any) {
        answerTextField(textField: redField)
    }
    
    @IBAction func inputGreenAction(_ sender: Any) {
        answerTextField(textField: greenField)
    }
    
    @IBAction func inputBlueAction(_ sender: Any) {
        answerTextField(textField: blueField)
    }
        
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}


extension SettingViewController {
    
    private func changeColor(sender: [UISlider]) {
        sender.forEach { slider in
            switch slider.tag {
            case 0:
                colors[slider.tag] = cropFloat(float: slider.value)
            case 1:
                colors[slider.tag] = cropFloat(float: slider.value)
            case 2:
                colors[slider.tag] = cropFloat(float: slider.value)
            default:
                break
            }
        }
        //updateRGB?.update(color: colors)
        colorIndicator(elements: colorIndicatorLabels)
        colorBackground()
    }

    private func colorIndicator(elements: [UILabel]) {
        elements.forEach { element in
            switch element.tag {
            case 0:
                element.text = String(colors[element.tag])
            case 1:
                element.text = String(colors[element.tag])
            case 2:
                element.text = String(colors[element.tag])
            default:
                break
            }
        }
    }
    
    private func cropFloat(float: Float) -> Float {
        (float * 100).rounded() / 100
    }
    
    private func colorBackground() {
        colorView.backgroundColor = UIColor(
            displayP3Red: CGFloat(colors[0]),
            green: CGFloat(colors[1]),
            blue: CGFloat(colors[2]),
            alpha: 1)
        updateRGB?.update(color: colors)
    }
    
    private func answerTextField(textField: UITextField) {
        switch textField.tag {
        case 0:
            answerQuantityCharacters(textField: textField)
        case 1:
            answerQuantityCharacters(textField: textField)
        case 2:
            answerQuantityCharacters(textField: textField)
        default:
            break
        }
    }
    
    
    private func answerQuantityCharacters(textField: UITextField) {
        if textField.text!.count <= 4 {
            if let float = Float(textField.text!) {
                colors[textField.tag] = float
                reloadColor()
            } else {
                alertTextField(title: "Ошибка", massege: "Недопустимые символы", titleButton: "OK")
            }
        } else {
            alertTextField(title: "Ошибка", massege: "Количество символом больше требуемого", titleButton: "OK")
            textField.text = ""
        }
    }
    
    private func reloadColor() {
        colorBackground()
        reloadSlider()
    }
    
    private func reloadSlider() {
        for (color, value) in zip(colors, colorSliders) {
            value.value = color
        }
        
        for (color, value) in zip(colors, colorIndicatorLabels) {
            value.text = String(color)
        }

    }
    
    
    private func alertTextField(title: String, massege: String, titleButton: String) {
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        let action = UIAlertAction(title: titleButton, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

