//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

enum Route {
    case OnboardingView
    case PinView
    case view3
    case home
    case segemntedView
    case loginView
    case listView

}

struct Navigator {
    static func navigate<T: View>(route: Route, content: () -> T) -> AnyView {
        switch route {
        case .OnboardingView:
            return AnyView(OnboardingView())
        case .PinView:
            return AnyView(EmptyView())
        case .view3:
            return AnyView(View3())
        case .home:
            return AnyView(HomeView())
        case .segemntedView:
            return AnyView(SegmentedView())
        case .loginView:
            return AnyView(loginView())
        case .listView:
            return AnyView(ListView())
        }
        
    }
}

class ViewRouter: ObservableObject {
    @Published var currentRoute: Route = .OnboardingView
    @Published var popCLicked:Bool = false
    @Published var tbabarTag:Int = 0
}

struct HomeView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        TabView{
            if !viewRouter.popCLicked{
                VStack {
                    NavigationLink(destination: Navigator.navigate(route: .OnboardingView) {
                        Text("Go to View 1")
                    }) {
                        Text("View 1")
                    }
                }
                .navigationTitle("Home")
            }else{
                VStack {
                    NavigationLink(destination: Navigator.navigate(route: viewRouter.currentRoute == .OnboardingView ? .OnboardingView: viewRouter.currentRoute) {
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

struct CustomPageControl: View {
    var numberOfPages: Int
    var currentPage: Int = 0
    var visitedPages: [Bool]
    
    var body: some View {
            HStack(spacing: 8) {
                ForEach(0..<numberOfPages) { index in
//                        Rectangle()
//                            .fill(currentPage == 0 ? Color.black : Color.gray)
//        //                    .fill(index == currentPage ? Color.black : Color.gray)
//                            .frame(width: 110, height: 2)
                        ZStack{
                            Color.gray
                                Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient:Gradient(colors: [Color.gray, Color.black]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                ).mask(
                                        Rectangle()
                                            .frame(width: visitedPages[index] || index == currentPage ? 110 : 0, height: 2)
                                            .animation(currentPage > 0 ? .linear(duration: 4) : .easeIn(duration: 0))
                                    )
                                
                        }.frame(width: 110, height: 2)
                            
                    }
                   
                }.padding()
            }
        
        
    }


struct PageModel: Identifiable{
    var id = UUID()
    var title: String?
    var description: String?
    var image: String?
    var tag: Int?
}


struct OnboardingView: View {
    @State private var currentPage = 0
    let numberOfPages = 3
    
    @State private var timer: Timer?

    
    @State private var visitedPages = [true, false, false]
    
     var pages : [PageModel] = [
        PageModel(title: "Add Money", description: "Load your wallet instantly from any funding source easily and conviniently", image: "Welcome", tag: 0),
        PageModel(title: "Peer-to-peer", description: "Load your wallet instantly from any funding source easily and conviniently ", image: "PayFriends", tag: 1),
        PageModel(title: "International Transfer (Cash-pickup, Wallet, Bank Transfer)", description: "Load your wallet instantly from any funding source easily and conviniently ", image: "Handwithphone", tag: 2)
    ]
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            if currentPage <= 1{
                currentPage += 1
            }
        }
    }
    
    var body: some View {
        VStack {
            CustomPageControl(numberOfPages: numberOfPages, currentPage: currentPage, visitedPages: visitedPages)
            TabView(selection: $currentPage) {
                
                ForEach(pages.indices, id: \.self, content: { index in
                    VStack(){
                        VStack(alignment: .leading,spacing: 10){
                            Text(pages[index].title ?? "")
                                .font(.headline)
                                .fontWeight(.heavy)
                            Text(pages[index].description ?? "").font(.subheadline).foregroundColor(Color.gray)
                        }
                        .padding(.horizontal,16)
                        Image(pages[index].image ?? "")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        
                    }
                    .tag(index)
                    
                })
                
            }
            .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            
            NavigationLink(destination: Navigator.navigate(route: .loginView) {
                Text("Go to View 1")
            }) {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Color.black)
                
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack{
                            Rectangle()
                                .fill(Color.yellow)
                                .cornerRadius(12)
                            
                        }
                    )
                    .padding()
                
            }


        }.onAppear{
//            startTimer()
        }
//        .onTapGesture(count: 1) {
//            if currentPage <= 1{
//                currentPage += 1
//            }
//        }
        .onChange(of: currentPage) { newValue in
            print("newValue is: \(newValue) \n currentPage is: \(currentPage) \n visitedPages is: \(visitedPages) \n visitedPagesCount is: \(visitedPages.count) \n  ")
            visitedPages[newValue] = true
            if currentPage == 1{
                visitedPages[2] = false
            }else if currentPage == 0{
                visitedPages[1] = false
            }
        }
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
        OnboardingView()
            .environmentObject(ViewRouter())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
