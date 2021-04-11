//
//  SettingsViewController.swift
//  LessonSixHomework
//
//  Created by Philip Noskov on 10.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueTF: UITextField!
    @IBOutlet weak var greenValueTF: UITextField!
    @IBOutlet weak var blueValueTF: UITextField!
    
    // MARK: - Public Properties
    
    var backgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 15
        mainView.backgroundColor = backgroundColor
        
        getValueFromMainView()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setTextFieldValue(for: redValueTF, greenValueTF, blueValueTF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
                
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setTextFieldValue(for: redValueTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setTextFieldValue(for: greenValueTF)
        default:
            setValue(for: blueValueLabel)
            setTextFieldValue(for: blueValueTF)
        }
    }
   
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(from: mainView.backgroundColor ?? .black)
        dismiss(animated: true)
    }
    
   // MARK: - Private Methods
    
    private func setColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setTextFieldValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF:
                textField.text = string(from: redSlider)
            case greenValueTF:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func getValueFromMainView() {
        if let color = backgroundColor {
            let redValue = color.components.red
            let greenValue = color.components.green
            let blueValue = color.components.blue

            redSlider.value = Float(redValue)
            greenSlider.value = Float(greenValue)
            blueSlider.value = Float(blueValue)
        }


    }
}

    // MARK: - Extensions

extension UIColor {
    var viewColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let viewColor = self.viewColor
        return (viewColor.red, viewColor.green, viewColor.blue, viewColor.alpha)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text  else { return }
        if let value = Float(text) {
            switch textField {
            case redValueTF: redSlider.value = value
            case greenValueTF: greenSlider.value = value
            case blueValueTF: blueSlider.value = value
            default: break
            }
            setColor()
            setValue()
        } else {
            print("Error")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
