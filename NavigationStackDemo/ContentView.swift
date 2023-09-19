//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

enum Route {
    case prepare(String)
    case confirm(String)
    case success(String)
}

struct Navigator {
    static func navigate<T: View>(route: Route, content: () -> T) -> AnyView {
        switch route {
        case .prepare(let name):
            return AnyView(
                NavigationLink(
                    destination: PrepareView(name: name),
                    label: {
                        content()
                    }
                )
            )
        case .confirm(let confirmModel):
            return AnyView(
                NavigationLink(
                    destination: ConfirmView(name: confirmModel),
                    label: {
                        content()
                    }
                )
            )
        case .success(let successModel):
            return AnyView(
                NavigationLink(
                    destination: SuccessView(name: successModel),
                    label: {
                        content()
                    }
                )
            )
        }
    }
}

struct ContentView: View {
    let views = ["home", "prepare", "confirm","succes"]
    var body: some View {
        NavigationView{
            VStack {
                    Navigator.navigate(route: .prepare("preparingg")){
                        Text("Go to Prepare")
                            .foregroundColor(Color.red)
                    }
                
            }
            .padding()
        }
    }
}

struct PrepareView: View {
    var name: String
    
    var body: some View {
        NavigationView{
            Form {
                Text(name)
                    .font(.largeTitle)
                    Navigator.navigate(route: .confirm("confirming")){
                        
                        Button{
                            
                        }label: {
                            Text("go to Confirm")
                                .foregroundColor(Color.red)
                        }
                        
                    }
                
            }
        }
    }
}
struct ConfirmView: View {
    var name: String
    
    var body: some View {
        NavigationView{
            Form {
                Text(name)
                    .font(.largeTitle)
                Navigator.navigate(route: .success("This is success screen")){
                    
                    Button{
                        
                    }label: {
                        Text("go to success")
                            .foregroundColor(Color.red)
                    }
                    
                }
                
            }
        }
    }
}
struct SuccessView: View {
    var name: String
    
    var body: some View {
        NavigationView{
            Form {
                Text(name)
                    .font(.largeTitle)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
