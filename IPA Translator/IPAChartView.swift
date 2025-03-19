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
    IPAChartView(isDarkMode: .constant(false))
}
