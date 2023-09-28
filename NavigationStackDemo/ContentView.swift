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
    case segemntedView

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
        case .segemntedView:
            return AnyView(SegmentedView())
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

//struct View1: View {
//    init() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = .black
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
//
//        UIPageControl.appearance().backgroundStyle = .prominent
//        UIPageControl.appearance().preferredIndicatorImage = UIImage(named: "status")
//        UIPageControl.appearance().backgroundColor = .clear
//        UIPageControl.appearance().backgroundStyle = .minimal
//    }
//    var body: some View {
//        TabView{
//            Text("First")
//            VStack {
//                Text("Second")
//                NavigationLink(destination: Navigator.navigate(route: .view2) {
//                    Text("Go to View 2 from View 1")
//                }) {
//                    Text("Go to View 2")
//                }
//            }
//            VStack {
//                Text("Third")
//                NavigationLink(destination: Navigator.navigate(route: .segemntedView) {
//                    Text("Go to View 2 from View 1")
//                }) {
//                    Text("Go to Segmented View")
//                }
//            }
//            .navigationBarTitle("View 1", displayMode: .inline)
//
//            Text("Fourth")
//        }.tabViewStyle(.page)
//            .indexViewStyle(.page(backgroundDisplayMode: .automatic))
//    }
//}

struct CustomPageControl: View {
    var numberOfPages: Int
    var currentPage: Int
    var visitedPages: [Bool]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages) { index in
                Rectangle()
                    .fill(visitedPages[index] || index == currentPage ? Color.black : Color.gray)
                    .frame(width: 80, height: 2)
            }
        }
        .padding()
    }
}

struct View1: View {
    @State private var currentPage = 0
    let numberOfPages = 4
    @State private var visitedPages = [true, false, false, false]
    
    var body: some View {
        VStack {
            CustomPageControl(numberOfPages: numberOfPages, currentPage: currentPage, visitedPages: visitedPages)
            TabView(selection: $currentPage) {
                Text("First").tag(0)
                            VStack {
                                Text("Second")
                                NavigationLink(destination: Navigator.navigate(route: .view2) {
                                    Text("Go to View 2 from View 1")
                                }) {
                                    Text("Go to View 2")
                                }
                            }
                            .tag(1)
                            VStack {
                                Text("Third")
                                NavigationLink(destination: Navigator.navigate(route: .segemntedView) {
                                    Text("Go to View 2 from View 1")
                                }) {
                                    Text("Go to Segmented View")
                                }
                            }
                            .navigationBarTitle("", displayMode: .inline)
                            .tag(2)

                Text("Fourth").tag(3)
                        }
            .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .automatic))

        }
        .padding()
        .onChange(of: currentPage) { newValue in
            print("newValue is: \(newValue) \n currentPage is: \(currentPage) \n visitedPages is: \(visitedPages) \n visitedPagesCount is: \(visitedPages.count) \n  ")
            visitedPages[newValue] = true
            if currentPage == 1{
                visitedPages[2] = false
            }else if currentPage == 2{
                visitedPages[3] = false
            }else if currentPage == 0{
                visitedPages[1] = false
            }
        }
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




struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
            .environmentObject(ViewRouter())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
