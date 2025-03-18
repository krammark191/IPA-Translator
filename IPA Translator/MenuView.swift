//
//  MenuView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//

import SwiftUI

struct MenuView: View {
   @Binding var isDarkMode: Bool
   @State private var showMenu = false
   
   var body: some View {
      Button(action: {
         showMenu.toggle()
         print("Tapped hamburger menu icon")
      }) {
         Image(systemName: "line.3.horizontal")
            .foregroundColor(.primary)
            .padding(10)
      }
      .popover(isPresented: $showMenu) {
         VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: IPAChartView(isDarkMode: $isDarkMode)) {
               Label("IPA Chart", systemImage: "chart.bar")
            }
            NavigationLink(destination: ConjugationChartView(isDarkMode: $isDarkMode)) {
               Label("Conjugation Chart", systemImage: "tablecells")
            }
            NavigationLink(destination: AboutView(isDarkMode: $isDarkMode)) {
               Label("About", systemImage: "info.circle")
            }
            Divider()
            Toggle("Dark Mode", isOn: $isDarkMode)
         }
         .padding()
         .frame(width: 200) // Adjust as needed
      }
   }
}

#Preview {
   MenuView(isDarkMode: .constant(false))
}
