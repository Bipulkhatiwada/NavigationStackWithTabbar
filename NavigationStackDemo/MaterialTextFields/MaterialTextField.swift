//
//  MaterialTextField.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 01/10/2023.
//

import Foundation
import SwiftUI
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons

import Combine

enum TextFieldType{
    case phoneNumber
    case none
}

struct MDCOutlinedTextFieldWrapper: UIViewRepresentable {
    @Binding var text: String
    @Binding var Titletext: String
    @Binding var helperText: String
    @Binding var placeHolder: String
    @Binding var textFieldType: TextFieldType
    

    func makeUIView(context: Context) -> MDCOutlinedTextField {
        let textField = MDCOutlinedTextField()
        textField.label.text = Titletext
        textField.placeholder = placeHolder
        textField.leadingAssistiveLabel.text = helperText
        textField.setFloatingLabelColor(UIColor.systemYellow, for: .normal)
        textField.layer.borderColor = UIColor.systemYellow.cgColor

        textField.sizeToFit()
        return textField
    }

    func updateUIView(_ uiView: MDCOutlinedTextField, context: Context) {
        uiView.text = text
        uiView.tintColor = UIColor.systemYellow
        if textFieldType == .phoneNumber {
            uiView.keyboardType = .numberPad
        }
    }
}


struct MDCFloatingButtonWrapper: UIViewRepresentable {
    @Binding var buttonTitle: String
    @Binding var bgColor: UIColor

    func makeUIView(context: Context) -> MDCFloatingButton {
        let button = MDCFloatingButton()
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = bgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.sizeToFit()
        return button
    }

    func updateUIView(_ uiView: MDCFloatingButton, context: Context) {
        // Update button properties if needed
    }
}


