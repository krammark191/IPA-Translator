//
//  ConjugationChartView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import SwiftUI

struct ConjugationChartView: View {
   @Binding var isDarkMode: Bool
   
   var body: some View {
      NavigationView {
         Text("Conjugation Chart Page")
            .font(.title)
            .navigationTitle("Conjugation Chart")
            .toolbar {
               ToolbarItem {
                  Menu {
                     NavigationLink(destination: ContentView(isDarkMode: $isDarkMode)) {
                        Label("Home", systemImage: "house")
                     }
                     NavigationLink(destination: IPAChartView(isDarkMode: $isDarkMode)) {
                        Label("IPA Chart", systemImage: "chart.bar")
                     }
                     NavigationLink(destination: ConjugationChartView(isDarkMode: $isDarkMode)) {
                        Label("Conjugation Chart", systemImage: "tablecells")
                     }
                     NavigationLink(destination: AboutView(isDarkMode: $isDarkMode)) {
                        Label("About", systemImage: "info.circle")
                     }
                     Section {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                     }
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
    ConjugationChartView(isDarkMode: .constant(false))
}
