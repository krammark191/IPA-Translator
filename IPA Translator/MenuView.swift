//
//  MenuView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//

import SwiftUI

struct MenuView: View {
   @Binding var isDarkMode: Bool
   
   var body: some View {
      NavigationView {
         MenuContent(isDarkMode: $isDarkMode)
            .navigationTitle("Menu")
      }
   }
}

struct MenuContent: View {
   @Binding var isDarkMode: Bool
   
   var body: some View {
      VStack {
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
      }
      .padding()
   }
}

#Preview {
   MenuView(isDarkMode: .constant(false))
}
