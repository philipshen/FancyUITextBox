//
//  TextBoxView.swift
//  FancyTextBox
//
//  Created by Philip Shen on 3/6/18.
//  Copyright © 2018 Philip Shen. All rights reserved.
//

import UIKit

class TextBoxView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var hiddenTextField: UITextField!
    @IBOutlet var numberLabels: [UILabel]! {
        didSet {
            numberLabels.forEach { (numberLabel) in
                numberLabel.layer.borderWidth = 1
                numberLabel.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("TextBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        hiddenTextField.becomeFirstResponder()
        focus(label: numberLabels[0])
    }
    
    private func focus(label: UILabel) {
        label.layer.borderColor = UIColor.red.cgColor
    }
    
    private func unfocus(label: UILabel) {
        label.layer.borderColor = UIColor.gray.cgColor
    }
    
}

// MARK: - Text field delegate methods
extension TextBoxView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count + textField.text!.count > numberLabels.count { return false }
        
        numberLabels[range.location].text = string
        
        // Styling to represent focus
        let backspacePressed = string == ""
        if backspacePressed {
            if range.location != numberLabels.count - 1 {
                unfocus(label: numberLabels[range.location + 1])
            }
            numberLabels[range.location].layer.borderColor = UIColor.red.cgColor
        } else if !backspacePressed && range.location != numberLabels.count - 1 {
            numberLabels[range.location].layer.borderColor = UIColor.gray.cgColor
            numberLabels[range.location + 1].layer.borderColor = UIColor.red.cgColor
        }
        
        return true
    }
    
}
