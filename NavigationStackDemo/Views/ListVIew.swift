//
//  ListVIew.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 02/10/2023.
//

import Foundation
import SwiftUI

struct ListView: View {
    @State private var isSection2Expanded: Bool = false
    var body: some View {
        NavigationView{
            List {
                Section(header:Text("Section 1")) {
                    Text("Static row 1")
                    Text("Static row 2")
                }
                
                Section (header:Text("Section 2")) {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }
                
                Section(header:Text("Section 2")) {
                    Text("Static row 3")
                    Text("Static row 4")
                }
//                DisclosureGroup(
//                    isExpanded: $isSection2Expanded,
//                    content: {
//                        ForEach(0..<5, id: \.self) { index in
//                            Text("Dynamic row \(index)")
//                        }
//                    },
//                    label: {
//                        Text("Section 2")
//                    }
//                )
            }

            
        }
           }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

   
//   var body: some View {
//       NavigationView {
//           List {
//               Section ("Section 1") {
//                   Text("Static row 1")
//                   Text("Static row 2")
//               }
//
//               Section ("Section 2") {
//                   ForEach(0..<5) {
//                       Text("Dynamic row \($0)")
//                   }
//               }
//
//               Section ("Section 3") {
//                   Text("Static row 3")
//                   Text("Static row 4")
//               }
//
//           }
//
//           List(people, id: \.self) {
//               Text($0)
//           }
//
//               .listStyle(.grouped)
//               .navigationTitle("Word Scramble")
//               .navigationBarTitleDisplayMode(.inline)
//
//
//       }
//   }
