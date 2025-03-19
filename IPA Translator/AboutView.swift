//
//  AboutView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import SwiftUI

struct AboutView: View {
   @Binding var isDarkMode: Bool
   
   var body: some View {
      NavigationView {
         VStack(spacing: 20) {
            Text("About IPA Translator")
               .font(.title)
            Text("Created by Mark Van Horn")
            Text("Version 1.0")
            Text("This app translates text into the International Phonetic Alphabet (IPA) for various languages.")
               .multilineTextAlignment(.center)
               .padding()
         }
         .navigationTitle("About")
         .toolbar {
            ToolbarItem {
               Menu {
                  MenuContent(isDarkMode: $isDarkMode)
               } label: {
                  Image(systemName: "line.horizontal.3")
               }
            }
         }
         .preferredColorScheme(isDarkMode ? .dark : .light)
      }
   }
}

#Preview {
    AboutView(isDarkMode: .constant(false))
}
