//
//  SucessView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 17/10/2023.
//

import Foundation
import SwiftUI
import LocalAuthentication


struct SuccessView: View {
    @State private var savePasswordUsingFaceID: Bool = UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID")
    @State private var isPasswordSaved: Bool = false
    
    var body: some View {
        VStack {
            Text("Login Successful!")
                .padding()
            
            Toggle(isOn: $savePasswordUsingFaceID, label: {
                Text("enable faceId for login")
            })
            .padding()
            
//            Button(action: {
//                if savePasswordUsingFaceID {
//                    savePasswordToKeychain()
//                } else {
//                    removePasswordFromKeychain()
//                }
//            }) {
//                Text(savePasswordUsingFaceID ? "Save Password" : "Remove Password")
//                    .font(.headline)
//                    .padding()
//                    .frame(width: 200, height: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
        }
        .onAppear{
            print(UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID"))
        }
        .onChange(of: savePasswordUsingFaceID, perform: { status in
            if status {
                savePasswordToKeychain()
            } else {
                removePasswordFromKeychain()
            }
        })
        .padding()
        .navigationTitle("Success")
    }
    
   
    private func savePasswordToKeychain() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID and the user has enrolled in it
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to save the password using Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful, save the password to Keychain
                        savePasswordUsingBiometrics()
                        savePasswordUsingFaceID = true
                    } else {
                        // Authentication failed
                        removePasswordFromKeychain()
                        savePasswordUsingFaceID = false
                    }
                }
            }
        } else {
            // Device doesn't support Face ID or the user hasn't enrolled
            print("Face ID is not available")
        }
    }

    private func savePasswordUsingBiometrics() {
        isPasswordSaved = true
        // Save the toggle state to UserDefaults
        UserDefaults.standard.set(savePasswordUsingFaceID, forKey: "savePasswordUsingFaceID")
    }
    
    private func removePasswordFromKeychain() {
        // Replace with your logic to remove the password from Keychain
        isPasswordSaved = false
        
        // Save the toggle state to UserDefaults
        UserDefaults.standard.set(savePasswordUsingFaceID, forKey: "savePasswordUsingFaceID")
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
