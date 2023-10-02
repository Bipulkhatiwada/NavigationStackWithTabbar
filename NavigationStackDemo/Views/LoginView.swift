//
//  LoginView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 01/10/2023.
//

import Foundation
import SwiftUI

struct loginView: View{
    
    let countryCodesAndPrefixes: [String: String] = [
        "US": "+1",   // United States
        "CA": "+1",   // Canada
        "MX": "+52",  // Mexico
        "BR": "+55",  // Brazil
        "GB": "+44",  // United Kingdom
        "FR": "+33",  // France
        "DE": "+49",  // Germany
        "JP": "+81",  // Japan
        "AU": "+61",  // Australia
        "IN": "+91"   // India
    ]
    
    @State private var isSheetPresented = false
    @State var showPasswordFIeld = false
    @State private var selectedCountryCode: String? = nil
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    
    @State private var phNumberPlaceholder: String = "Enter your phone Number"
    @State private var passwordPlaceholder: String = "Enter your phone Number"
    @State private var textFieldtTitle: String = "Phone"
    @State private var passFieldtTitle: String = "password"
    
    @State private var username: String = ""
    @State private var usernamePlaceholder: String = "Enter your username"
    @State private var usernametextFieldtTitle: String = "Username"
    
    @State private var helperText: String = ""
    @State private var ButtonTitle: String = "Next"
    @State private var walletTagTitle: String = "use @CwalletTag"
    
    @State private var cWalletTagBg: UIColor = .clear
    @State private var NextBtnBg: UIColor = .systemYellow
    
    @State private var isBottomSheetPresented = false
    
    @State private var usedCwalletTag = false
    
    @State private var textFieldTypeOne:TextFieldType = .phoneNumber
    @State private var textFieldTypeTwo:TextFieldType = .none
    
    @State private var countryCodeImage:String = "gear"
    
    
    @State private var titleDesc:String = "Enter your 10 digit phone number to get started"
    @State private var termsAndCondition:String = "By Continuing you agree to the Terms & Condition"
    
    @ObservedObject var keyboardHeightObservable = KeyboardHeightObservable()
    
    
    
    var languages:[String] = ["en","ne"]
    @State private var languageMode:String = ""
    
    
    
    
    // In an initializer or method
    init() {
        _selectedCountryCode = State(initialValue: countryCodesAndPrefixes["US"])
    }
    
    private var countryCodesArray: [(String, String)] {
        return countryCodesAndPrefixes.map { ($0.value, $0.key) }
    }
    
    var body: some View{
        
        
        ScrollView{
            
            VStack{
                VStack{
                    VStack(alignment: .leading,spacing: 8){
                        Text("Phone")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text(titleDesc)
                            .font(.subheadline)
                    }.padding(.vertical,16)
                    
                    
                    
                    VStack(spacing:158){
                        if usedCwalletTag == false{
                            VStack(spacing: 15){
                                HStack{
                                    HStack(spacing: 0){
                                        Image(systemName: countryCodeImage)
                                            .foregroundColor(Color.black)
                                            .padding(.leading,8)
                                        Picker("Select Country Code", selection: $selectedCountryCode) {
                                            ForEach(countryCodesArray, id: \.0) { countryCode, _ in
                                                Text(countryCode).tag(countryCode as String?)
                                            }
                                        }.foregroundColor(Color.yellow)
                                            .labelsHidden()
                                    }.frame(height: 55)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.yellow, lineWidth: 1)
                                        )
                                        .padding(.leading,16)
                                    HStack{
                                        //                                        MDCOutlinedTextFieldWrapper(text: $phoneNumber, Titletext: $textFieldtTitle, helperText: $helperText, placeHolder: $phNumberPlaceholder, textFieldType: $textFieldTypeOne)
                                        TextField("Phone Number", text: $phoneNumber)
                                            .keyboardType(.numberPad)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.yellow, lineWidth: 1)
                                            )
                                        
                                        
                                    }
                                    
                                    .padding(.trailing,16)
                                    
                                }
                                if showPasswordFIeld{
                                    HStack{
                                        //                                        MDCOutlinedTextFieldWrapper(text: $password, Titletext: $passFieldtTitle, helperText: $helperText, placeHolder: $passwordPlaceholder, textFieldType: $textFieldTypeTwo)
                                        TextField("Password", text: $password)
                                            .padding()
                                            .textContentType(.password)
//                                            .secureField("Password", text: $password)
                                        .overlay(
                                                Button(action: {
                                                    password = ""  // Clear the password
                                                }) {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .foregroundColor(.gray)
                                                        .padding(.trailing, 10)
                                                }
                                                    .opacity(password.isEmpty ? 0 : 1)  // Show the button only when there's text
                                                    .animation(.none)
                                                , alignment: .trailing
                                            )
                                            
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.yellow, lineWidth: 1)
                                            )
                                        
                                    }.padding()
                                }
                            }
                        }else{
                            HStack{
                                //                                MDCOutlinedTextFieldWrapper(text: $username, Titletext: $usernametextFieldtTitle, helperText: $helperText, placeHolder: $usernamePlaceholder, textFieldType: $textFieldTypeTwo)
                                TextField("Username", text: $username)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                            .padding(.horizontal,16)
                            
                        }
                        VStack(alignment: .leading, spacing:16){
                            Text(termsAndCondition).padding(.leading,16)
                            HStack{
                                //                                MDCFloatingButtonWrapper(buttonTitle: $walletTagTitle, bgColor: $cWalletTagBg)
                                Text(walletTagTitle)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(Color.black)
                                
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        ZStack{
                                            Rectangle()
                                                .fill(Color.white)
                                                .cornerRadius(12)
                                                .shadow(radius: 14)
                                            
                                        }
                                    )
                                
                                    .onTapGesture {
                                        usedCwalletTag.toggle()
                                        if usedCwalletTag == true{
                                            walletTagTitle = "use Phone"
                                        } else{
                                            walletTagTitle = "use @CwalletTag"
                                            
                                        }
                                    }
                                Button{
                                  isSheetPresented = true
                                } label:{
                                    //                                    MDCFloatingButtonWrapper(buttonTitle: $ButtonTitle, bgColor: $NextBtnBg)
                                    Text(ButtonTitle)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(Color.black)
                                    
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            ZStack{
                                                Rectangle()
                                                    .fill(Color.yellow)
                                                    .cornerRadius(12)
                                                    .shadow(radius: 14)
                                                
                                            }
                                        )
                                    
                                }
                                
                            }.padding(.horizontal,14)
                            
                        }
                        .padding(.bottom, keyboardHeightObservable.keyboardHeight)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                }
            }
        }
        .navigationBarTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Picker("Select Language", selection: $languageMode) {
            ForEach(languages, id: \.self) { langMode in
                Text(langMode).tag(langMode as String?)
            }
        }.foregroundColor(Color.yellow)
            .labelsHidden()        )
        .gesture(
            TapGesture().onEnded {
                self.isBottomSheetPresented = false
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
        )
        
        .overlay(
            BottomSheet(isPresented: $isBottomSheetPresented) {
                // Content for the botto sheet
                VStack{
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width:100,height: 100)
//                    Image("Welcome to CWallet")
//                        .font(.subheadline)
                    Button{
                        isBottomSheetPresented = false
                    }label: {
                        HStack{
                            Image(systemName: "xmark")
                            Text("close")
                                .underline()
                        }
                    }
                    
                }.frame(maxWidth: .infinity)
                
            }
            
        )
        .fullScreenCover(isPresented: $isSheetPresented, content: {
            PinView(isSheetPresented: $isSheetPresented)
        })

        .onChange(of: phoneNumber, perform: { phoneNumber in
            print("(phoneNumber:::::)\(phoneNumber.count)")
            if phoneNumber.count > 9{
                showPasswordFIeld = true
            }else{
                showPasswordFIeld = false
            }
        })
        .onChange(of:selectedCountryCode ) { newCountryCode in
            switch newCountryCode {
            case "+1":
                countryCodeImage = "house"
            case "+52":
                countryCodeImage = "globe"
            case "+55":
                countryCodeImage = "flag"
            case "+44":
                countryCodeImage = "square.and.arrow.down"
            case "+33":
                countryCodeImage = "arrow.up.and.down"
            case "+49":
                countryCodeImage = "flag.circle"
            case "+81":
                countryCodeImage = "phone"
            case "+61":
                countryCodeImage = "star"
            case "+91":
                countryCodeImage = "bell"
            default:
                countryCodeImage = "questionmark"
            }
        }
        .onChange(of: languageMode) { langMode in
            switch langMode{
            case "en":
                titleDesc = "Enter your 10 digit phone number to get started"
                termsAndCondition = "By Continuing you agree to the Terms & Condition"
            case "ne":
                titleDesc = "सुरु गर्नका लागि आफ्नो १० अंकको फोन नम्बर प्रविष्ट गर्नुहोस्"
                termsAndCondition = "जारी राख्न बाट तपाईंले निम्नलिखित शर्त र गरि सहमत गर्नुहुन्छ"
            default:break
                
            }
        }.navigationBarBackButtonHidden()
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
