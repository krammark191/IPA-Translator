//
//  IPA_TranslatorApp.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/13/25.
//

import SwiftUI

@main
struct IPA_TranslatorApp: App {
   @State private var isDarkMode: Bool = UITraitCollection.current.userInterfaceStyle == .dark
   
   var body: some Scene {
      WindowGroup {
         ContentView(isDarkMode: $isDarkMode)  // Pass the binding here
      }
   }
}
