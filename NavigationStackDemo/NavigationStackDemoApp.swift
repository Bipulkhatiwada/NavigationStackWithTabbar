//
//  NavigationStackDemoApp.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

@main
struct NavigationStackDemoApp: App {
    init() {
         // Customize navigation bar appearance
         let appearance = UINavigationBarAppearance()
//        appearance.setBackIndicatorImage(UIImage(systemName: "arrow.left.circle.fill"), transitionMaskImage: UIImage(systemName: "arrow.left.circle.fill"))
         appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellow]

//         UINavigationBar.appearance().standardAppearance = appearance
         UINavigationBar.appearance().scrollEdgeAppearance = appearance
     }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                tabbarContentView()
            }.environmentObject(ViewRouter())
//                .toolbarRole(.editor)
            
        }
    }
}

struct tabbarContentView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
//    @State private var selectedTab = 1

    var body: some View {
        TabView {
            HomeView()
                .navigationTitle("Home")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Tab 1")
                }
                .tag(viewRouter.tbabarTag)
        }
//        .onAppear {
//            selectedTab = 1  // Initially select the second tab
//        }
    }
}
extension UINavigationController{
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationBar.tintColor = .systemYellow
    }
}
