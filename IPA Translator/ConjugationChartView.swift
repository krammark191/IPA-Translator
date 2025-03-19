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
    ConjugationChartView(isDarkMode: .constant(false))
}
