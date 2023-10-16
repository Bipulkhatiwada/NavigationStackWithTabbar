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

class KeyboardHeightObservable: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                return notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                return rect.height
            }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .map { _ in
                return CGFloat(0)
            }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
}

struct FloatingButton<Content: View>: View {
    let action: () -> Void
    let content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        Rectangle()
                            .fill(Color.yellow)
                            .cornerRadius(50)
                    }
                )
                .padding()
        }
    }
}


