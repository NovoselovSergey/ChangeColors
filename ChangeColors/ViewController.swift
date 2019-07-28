//
//  ViewController.swift
//  ChangeColors
//
//  Created by Sergey Novoselov on 28/07/2019.
//  Copyright © 2019 Sergey Novoselov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
    
    var redColor: CGFloat = 0
    var greenColor: CGFloat = 0
    var blueColor: CGFloat = 0
    let alpha: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.redColorTextField.delegate = self
        self.greenColorTextField.delegate = self
        self.blueColorTextField.delegate = self
        
        self.addDoneButtonOnKeyboard()
        
        viewLabel.layer.cornerRadius = 10
        
        //Setup sliders
        redColorSlider.value = 0
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.value = 0
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.value = 0
        blueColorSlider.minimumTrackTintColor = .blue
        
        redColorLabel.text = String(redColorSlider.value)
        greenColorLabel.text = String(greenColorSlider.value)
        blueColorLabel.text = String(blueColorSlider.value)
        
        redColorTextField.text = String(redColorSlider.value)
        greenColorTextField.text = String(greenColorSlider.value)
        blueColorTextField.text = String(blueColorSlider.value)
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.barTintColor = .gray
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        redColorTextField.inputAccessoryView = doneToolbar
        greenColorTextField.inputAccessoryView = doneToolbar
        blueColorTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        redColorTextField.resignFirstResponder()
        greenColorTextField.resignFirstResponder()
        blueColorTextField.resignFirstResponder()
        
        if let _ = Float(redColorTextField.text!) {
            redColor = CGFloat(Float(redColorTextField.text!)!)
            redColorSlider.value = Float(redColor)
            redColorLabel.text = String(Float(redColor))
        } else {
            print("Wrong format")
        }
        
        if let _ = Float(greenColorTextField.text!) {
            greenColor = CGFloat(Float(greenColorTextField.text!)!)
            greenColorSlider.value = Float(greenColor)
            greenColorLabel.text = String(Float(greenColor))
        } else {
            print("Wrong format")
        }
        
        if let _ = Float(blueColorTextField.text!) {
            blueColor = CGFloat(Float(blueColorTextField.text!)!)
            blueColorSlider.value = Float(blueColor)
            blueColorLabel.text = String(Float(blueColor))
        } else {
            print("Wrong format")
        }
        
        viewLabel.backgroundColor = UIColor.init(red: redColor,
                                                 green: greenColor,
                                                 blue: blueColor,
                                                 alpha: alpha)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func redColorSliderAction() {
        redColor = CGFloat(redColorSlider.value)
        viewLabel.backgroundColor = UIColor.init(red: redColor,
                                                 green: greenColor,
                                                 blue: blueColor,
                                                 alpha: alpha)
        redColorLabel.text = String(format: "%.2f", redColorSlider.value)
        redColorTextField.text = String(format: "%.2f", redColorSlider.value)
    }
    @IBAction func greenColorSliderAction() {
        greenColor = CGFloat(greenColorSlider.value)
        viewLabel.backgroundColor = UIColor.init(red: redColor,
                                                 green: greenColor,
                                                 blue: blueColor,
                                                 alpha: alpha)
        greenColorLabel.text = String(format: "%.2f", greenColorSlider.value)
        greenColorTextField.text = String(format: "%.2f", greenColorSlider.value)
    }
    @IBAction func blueColorSliderAction() {
        blueColor = CGFloat(blueColorSlider.value)
        viewLabel.backgroundColor = UIColor.init(red: redColor,
                                                 green: greenColor,
                                                 blue: blueColor,
                                                 alpha: alpha)
        blueColorLabel.text = String(format: "%.2f", blueColorSlider.value)
        blueColorTextField.text = String(format: "%.2f", blueColorSlider.value)
    }
}

