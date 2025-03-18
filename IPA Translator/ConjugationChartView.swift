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
      Text("Conjugation Chart Page")
         .font(.title)
         .navigationTitle("Conjugation Chart")
         .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               MenuView(isDarkMode: $isDarkMode)
            }
         }
         .preferredColorScheme(isDarkMode ? .dark : .light)
   }
}

#Preview {
    ConjugationChartView(isDarkMode: .constant(false))
}
