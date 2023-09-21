//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

enum AppView {
    case login, main,dashboard
}

class ViewRouter: ObservableObject {
    // here you can decide which view to show at launch
    @Published var currentView: AppView = .login
}
struct RootView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentView == .login {
                LoginView()
            } else if viewRouter.currentView == .main {
                MainView()
            }else if viewRouter.currentView == .dashboard{
                DashBoardView()
            }
        }
    }
}

struct LoginView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("Login View")
            Button("Log in") {
                viewRouter.currentView = .main
            }
        }
    }
}

struct MainView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("Main View")
            Button("go to dashboard") {
                viewRouter.currentView = .dashboard
            }
        }
    }
}
struct DashBoardView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("dashboard View")
            Button("go to main ") {
                viewRouter.currentView = .login
            }
        }
    }
}
