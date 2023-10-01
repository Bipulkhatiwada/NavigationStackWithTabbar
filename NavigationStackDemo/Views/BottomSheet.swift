//
//  BottomSheet.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 01/10/2023.
//

import Foundation
import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    Rectangle()
                        .frame(width: 40, height: 5)
                        .cornerRadius(5)
                        .opacity(0.1)
                    self.content()
                }
                .background(Color.white)
                .cornerRadius(15)
                .padding()
                .frame(height: geometry.size.height * 0.6) // Adjust the height as needed
                .frame(width: geometry.size.width) // Adjust the height as needed
                .offset(y: self.isPresented ? 0 : geometry.size.height)
                .animation(.default)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height > 50 {
                                self.isPresented = false
                            }
                        }
                )
            }
        }
    }
}
