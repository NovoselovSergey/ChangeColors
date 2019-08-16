//
//  ViewController.swift
//  ChangeColors
//
//  Created by Sergey Novoselov on 28/07/2019.
//  Copyright © 2019 Sergey Novoselov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewLabel: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLabel.layer.cornerRadius = 15
        
        redColorSlider.tintColor = .red
        greenColorSlider.tintColor = .green
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        
        addDoneButtonTo(redColorTextField)
        addDoneButtonTo(greenColorTextField)
        addDoneButtonTo(blueColorTextField)
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redColorLabel.text = string(from: sender)
            redColorTextField.text = string(from: sender)
        case 1:
            greenColorLabel.text = string(from: sender)
            greenColorTextField.text = string(from: sender)
        case 2:
            blueColorLabel.text = string(from: sender)
            blueColorTextField.text = string(from: sender)
        default:
            break
        }
        setColor()
    }
    
    // Цвет вью
    private func setColor() {
        viewLabel.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
    }
    
    private func setValueForLabel() {
        redColorLabel.text = string(from: redColorSlider)
        greenColorLabel.text = string(from: greenColorSlider)
        blueColorLabel.text = string(from: blueColorSlider)
    }
    
    private func setValueForTextField() {
        redColorTextField.text = string(from: redColorSlider)
        greenColorTextField.text = string(from: greenColorSlider)
        blueColorTextField.text = string(from: blueColorSlider)
    }
    
    // Значения RGB
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

extension ViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру нажатием на "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Скрытие клавиатуры по тапу за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // Скрывает клавиатуру, вызванную для любого объекта
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0: redColorSlider.value = currentValue
            case 1: greenColorSlider.value = currentValue
            case 2: blueColorSlider.value = currentValue
            default: break
            }
            
            setColor()
            setValueForLabel()
        } else {
            showAlert(title: "Wrong format!",
                      message: "Please enter correct value")
        }
    }
}

extension ViewController {
    
    // Метод для отображения кнопки "Готово" на цифровой клавиатуре
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
