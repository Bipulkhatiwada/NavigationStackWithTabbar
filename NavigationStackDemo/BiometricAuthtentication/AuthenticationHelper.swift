//
//  AuthenticationHelper.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 16/10/2023.
//


import Foundation
import SwiftUI

class userInfo: ObservableObject {
    @Published var email: String = ""
}


struct KeychainHelper {
    private static let serviceName: String = "NavigationStackDemo"
    
    static func savePassword(_ password: String, forAccount account: String) {
        if let data = password.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: serviceName,
                kSecAttrAccount as String: account,
                kSecValueData as String: data
            ]
            
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Failed to save password to Keychain. Status: \(status)")
                return
            }
        }
    }
    
    static func retrievePassword(forAccount account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data, let password = String(data: retrievedData, encoding: .utf8) {
            return password
        } else {
            print("Failed to retrieve password from Keychain. Status: \(status)")
            return nil
        }
    }
}




