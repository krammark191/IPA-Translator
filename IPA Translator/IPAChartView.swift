//
//  IPAChartView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import SwiftUI

struct IPAChartView: View {
   @Environment(\.colorScheme) var colorScheme: ColorScheme
   
   var body: some View {
      NavigationView {
         Text("IPA Chart Page")
            .font(.title)
            .navigationTitle("IPA Chart")
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
    IPAChartView()
}
