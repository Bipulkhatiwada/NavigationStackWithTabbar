//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

enum Route {
    case view1
    case view2
    case view3
    case home

}

struct Navigator {
    static func navigate<T: View>(route: Route, content: () -> T) -> AnyView {
        switch route {
        case .view1:
            return AnyView(View1())
        case .view2:
            return AnyView(View2())
        case .view3:
            return AnyView(View3())
        case .home:
            return AnyView(HomeView())
        }
        
    }
}

class ViewRouter: ObservableObject {
    @Published var currentRoute: Route = .view1
    @Published var popCLicked:Bool = false
    @Published var tbabarTag:Int = 0
}

struct HomeView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        TabView{
            if !viewRouter.popCLicked{
                VStack {
                    NavigationLink(destination: Navigator.navigate(route: .view1) {
                        Text("Go to View 1")
                    }) {
                        Text("View 1")
                    }
                }
                .navigationTitle("Home")
            }else{
                VStack {
                    NavigationLink(destination: Navigator.navigate(route: viewRouter.currentRoute == .view1 ? .view1: viewRouter.currentRoute) {
                        Text("Go to View 1")
                    }) {
                        Text("View 1")
                    }
                }.onAppear{
                    //                    viewRouter.currentRoute = .view1
                }
                                
            }
        }
        .tabItem {
            Image(systemName: "1.circle")
            Text("Tab 1")
        }
    }
}

struct View1: View {
    var body: some View {
        VStack {
            Text("View 1")
            NavigationLink(destination: Navigator.navigate(route: .view2) {
                Text("Go to View 2 from View 1")
            }) {
                Text("Go to View 2")
            }
        }
        .navigationBarTitle("View 1", displayMode: .inline)
    }
}

struct View2: View {
    var body: some View {
        VStack {
            Text("View 2")
            NavigationLink(destination: Navigator.navigate(route: .view3) {
                Text("Go to View 3 from View 2")
            }) {
                Text("Go to View 3")
            }
        }
        .navigationBarTitle("View 2", displayMode: .inline)
    }
}

struct View3: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("View 3")
                .navigationBarTitle("View 3", displayMode: .inline)
            
            Button(action: {
                viewRouter.currentRoute = .home
                viewRouter.popCLicked = true
                viewRouter.tbabarTag = 0
            }) {
                Text("Go to Home")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
