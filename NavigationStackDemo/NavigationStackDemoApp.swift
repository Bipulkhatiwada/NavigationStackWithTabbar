//
//  NavigationStackDemoApp.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

@main
struct TestApp: App {
    @StateObject private var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewRouter)
        }
    }
}
