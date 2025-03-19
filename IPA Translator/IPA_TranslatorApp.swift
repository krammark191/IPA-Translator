//
//  IPA_TranslatorApp.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/13/25.
//

import SwiftUI

@main
struct IPA_TranslatorApp: App {
   @State private var isDarkMode: Bool = false
   
   var body: some Scene {
      WindowGroup {
         ContentView()  // Pass the binding here
      }
   }
}
