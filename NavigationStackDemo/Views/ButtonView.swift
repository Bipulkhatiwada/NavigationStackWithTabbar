//
//  ButtonView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 11/10/2023.
//

import Foundation
import SwiftUI

struct ActionButton: View{
    var body: some View{
        VStack {
            FloatingButton(action: {
                print("Button tapped!")
            }) {
                HStack {
//                    Image(systemName: "star.fill")
                    Text("Get Started")
                }
            }
            
        }
        .padding()

    }
}

struct ActionbuttonPreviewProvider:PreviewProvider{
    static var previews: some View{
        return ActionButton()
    }
}
