//
//  IPAChartView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import SwiftUI

struct IPAChartView: View {
   @Binding var isDarkMode: Bool
   
   var body: some View {
      NavigationView {
         Text("IPA Chart Page")
            .font(.title)
            .navigationTitle("IPA Chart")
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
    IPAChartView(isDarkMode: .constant(false))
}
