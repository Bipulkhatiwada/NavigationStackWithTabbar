//
//  PinVIew.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 02/10/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct PinView: View {
    
    @Binding var isSheetPresented: Bool

    var body: some View {
        VStack {
            HStack{
                
                Spacer()
                Button{
                    isSheetPresented.toggle()
                }label: {
                    Rectangle()
                        .fill(Color.yellow).opacity(0.3)
                        .cornerRadius(6)
                        .frame(width: 26,height: 26)
                        .overlay(
                            Image(systemName: "xmark")
                                .padding()
                                .font(.subheadline)
                                .foregroundColor(.black)
                        )
                    
                }
                .padding()
            }
           
            VStack{
                    WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
//                    .scaledToFit()
                    .cornerRadius(25)
                    .frame(width: 70, height: 70, alignment: .center)
            }.padding(.vertical,24)
            Text("Good afternoon, Bikash").font(.headline)
            Text("Enter your Wallet PIN").font(.subheadline)
            Spacer()
            PINEntryView()
                .frame(height: 450)
                
                
            Spacer()
        }
        
    }
    
}



//struct pinView_Previews:PreviewProvider{
//    @State private var show = false
//    static var previews: some View{
//        PinView(isSheetPresented: $show)
//    }
//}


import SwiftUI

struct PINEntryView: View {
    @State private var pin: String = ""
    private let pinLength = 4 // Change this according to your PIN length
    
    var body: some View {
        VStack {
            // PIN Indicator
            HStack(spacing: 10) {
                ForEach(0..<pinLength, id: \.self) { index in
                    Circle()
                        .fill(pin.count > index ? Color.black : Color.yellow.opacity(0.5))
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.bottom, 20)
            
            // Num Pad
            VStack(spacing: 10) {
                HStack {
                    NumberButton(number: 1, onTapped: { pin.append("1")
                        print(self.pin)
                    })
                    NumberButton(number: 2, onTapped: { pin.append("2")
                        print(self.pin)
                    })
                    NumberButton(number: 3, onTapped: { pin.append("3")
                        print(self.pin)
                    })
                }
                HStack {
                    NumberButton(number: 4, onTapped: { pin.append("4")
                        print(self.pin)
                    })
                    NumberButton(number: 5, onTapped: { pin.append("5")
                        print(self.pin)
                    })
                    NumberButton(number: 6, onTapped: { pin.append("6")
                        print(self.pin)
                    })
                }
                HStack {
                    NumberButton(number: 7, onTapped: { pin.append("7")
                        print(self.pin)
                    })
                    NumberButton(number: 8, onTapped: { pin.append("8")
                        print(self.pin)
                    })
                    NumberButton(number: 9, onTapped: { pin.append("9")
                        print(self.pin)
                    })
                }
                HStack {
                    Button(action: {
                        // Handle biometric authentication
                        print("Authenticate using biometrics")
                    }) {
                        Image(systemName: "faceid")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Circle().fill(Color.white))
                            .cornerRadius(20)
                            .shadow(radius: 3)
                    }
                    NumberButton(number: 0, onTapped: { pin.append("0") })
                    Button(action: {
                        pin = String(pin.dropLast())
                    }) {
                        Image(systemName: "delete.left")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Circle().fill(Color.white))
                            .cornerRadius(20)
                            .shadow(radius: 3)
                    }
                }
            }.padding(.vertical,16)
        }
        .padding()
    }
}

struct NumberButton: View {
    let number: Int
    let onTapped: () -> Void
    
    var body: some View {
        Button(action: {
            onTapped()
        }) {
            Text("\(number)")
                .font(.title)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Circle().fill(Color.white))
                .cornerRadius(20)
                .shadow(radius: 3)
                
        }
    }
}

struct PINEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PINEntryView()
    }
}




