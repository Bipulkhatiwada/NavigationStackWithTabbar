//
//  SegmentedVIew.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 27/09/2023.
//

import Foundation
import SwiftUI


struct personalDetail{
    let Name:String
    let cWalletTag:String
    let Address:String
    let Dob:String
    let phoneNumber:String
    let emailAddress:String
}

struct SegmentedView: View {
    @State private var selectedIndex = 0
    @State private var personalSegmentSelected:Bool = true
    @State private var documentsSegmentSelected:Bool = true

    var body: some View {
            VStack {
                Picker(selection: $selectedIndex, label: Text("What is your favorite view?")) {
                    Text("Personal Information").tag(0)
                    Text("Documents").tag(1)
                }
                //            .fixedSize()
                .background(personalSegmentSelected ? Color.white : Color.gray)
                .modifier(CustomPickerStyle())
                .padding()
                
                switch selectedIndex {
                case 0:
                    FirstView()
                case 1:
                    SecondView()
                default:
                    EmptyView()
                }
                
                VStack{
                    Spacer()
                    Button(action: {
                        print("Button tapped")
                    }) {
                        Text("Verify Documents")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
        
    }.navigationTitle("Personal Details")
        

    }
}

struct FirstView: View {
    @State private var showContents = false

    var detail:personalDetail = personalDetail(Name: "Ram Bahaur Thapa", cWalletTag: "@ram", Address: "Doha,Qatar", Dob: "2020/01/01", phoneNumber: "9861786015", emailAddress: "ram@gmail.com")
    
    var body: some View {
        Group{
            withAnimation {
                VStack(alignment: .leading,spacing: 16){
                    descripTionView(title: "name", description: detail.Name)
                    descripTionView(title: "C wallwt Tag", description: detail.cWalletTag)
                    descripTionView(title: "Address", description: detail.Address)
                    descripTionView(title: "Email", description: detail.emailAddress)
                    descripTionView(title: "Phone Number", description: detail.phoneNumber)
                    descripTionView(title: "Dob", description: detail.Dob)

                }
                .padding()
            }

        } .transition(.opacity)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
       
    }

struct SecondView: View {
    var body: some View {
        VStack(alignment: .leading, spacing:10){
                VStack(alignment: .leading){
                    Text("Documents")
                        .padding(.top,16)
                        .padding(.leading,16)
                }
                Image("Id")
                    .resizable()
                    .padding()
                    .frame(height: 200)
                HStack{
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("View Image")
                            .foregroundColor(Color.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            

                    }.padding()
                }
            }.background(Color.yellow.opacity(0.5))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
    }
}

struct CustomPickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
            .foregroundColor(.yellow)
    }
}

struct segmentedView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedView()
    }
}

struct descripTionView: View{
    var title:String
    var description:String
    
    var body: some View{
        VStack(alignment: .leading){
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(description)
                .font(.headline)
        }
    }
}


