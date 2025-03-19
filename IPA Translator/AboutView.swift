//
//  AboutView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import SwiftUI

struct AboutView: View {
   @Environment(\.colorScheme) var colorScheme: ColorScheme
   
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
                  NavigationLink(destination: ContentView()) {
                     Label("Home", systemImage: "house")
                  }
                  NavigationLink(destination: IPAChartView()) {
                     Label("IPA Chart", systemImage: "chart.bar")
                  }
                  NavigationLink(destination: ConjugationChartView()) {
                     Label("Conjugation Chart", systemImage: "tablecells")
                  }
                  NavigationLink(destination: AboutView()) {
                     Label("About", systemImage: "info.circle")
                  }
               } label: {
                  Image(systemName: "line.horizontal.3")
               }
            }
         }
         .preferredColorScheme(colorScheme)
      }
   }
}

#Preview {
   AboutView()
}
