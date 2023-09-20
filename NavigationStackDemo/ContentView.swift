//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 19/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(
                destination: ContentView2(rootIsActive: self.$isActive),
                isActive: self.$isActive
            ) {
                Text("Hello, World!")
            }
            .isDetailLink(false)
            .navigationBarTitle("Root")
        }
    }
}

struct ContentView2: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ContentView3(rootIsActive: self.$rootIsActive)) {
            Text("Hello, World #2!")
        }
        .isDetailLink(false)
        .navigationBarTitle("Two")
    }
}

struct ContentView3: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ContentView4(shouldPopToRootView: self.$rootIsActive)) {
            Text("Hello, World #2!")
        }
        .isDetailLink(false)
        .navigationBarTitle("Two")
    }
}
struct ContentView4: View {
    @Binding var shouldPopToRootView : Bool

    var body: some View {
        VStack {
            Text("Hello, World #3!")
            Button (action: { self.shouldPopToRootView = false } ){
                Text("Pop to root")
            }
        }.navigationBarTitle("Three")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


