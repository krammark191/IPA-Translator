//
//  ContentView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/13/25.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {
   @State private var inputText: String = ""
   @State private var ipaOutput: String = ""
   @State private var selectedLanguage: String = "English"
   
   @Environment(\.colorScheme) var colorScheme: ColorScheme
   
   let languages = ["English", "Spanish", "Italian", "Portuguese", "French", "Romanian", "German", "Polish", "Esperanto", "Russian"]
   let languagePlaceholders: [String: String] = [
      "English": "Enter text to translate",
      "Spanish": "Ingrese texto para traducir",
      "Italian": "Inserisci il testo da tradurre",
      "Portuguese": "Insira o texto para traduzir",
      "French": "Entrez le texte à traduire",
      "Romanian": "Introduceți textul de tradus",
      "German": "Geben Sie den zu übersetzenden Text ein",
      "Polish": "Wprowadź tekst do przetłumaczenia",
      "Esperanto": "Enigu tekston por traduki",
      "Russian": "Введите текст для перевода"
   ]
   let languageCodes: [String: String] = [
      "English": "en-US",
      "Spanish": "es-MX",
      "Italian": "it-IT",
      "Portuguese": "pt-BR",
      "French": "fr-FR",
      "Romanian": "ro-RO",
      "German": "de-DE",
      "Polish": "pl-PL",
      "Esperanto": "eo",
      "Russian": "ru-RU"
   ]
   let characterLimit = 2000
   
   var body: some View {
      NavigationView {
         ScrollView {
            VStack(spacing: 20) {
               HStack {
                  Picker("Select Language", selection: $selectedLanguage) {
                     ForEach(languages, id: \.self) { language in
                        Text(language)
                     }
                  }
                  .pickerStyle(MenuPickerStyle())
                  Spacer()
               }
               .padding()
               
               HStack {
                  TextField(languagePlaceholders[selectedLanguage] ?? "Enter text to translate", text: $inputText, onEditingChanged: { _ in
                     if inputText.count > characterLimit {
                        inputText = String(inputText.prefix(characterLimit))
                     }
                  })
                  .autocapitalization(.none)
                  .disableAutocorrection(true)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
                  .frame(height: 100)
                  
                  if !inputText.isEmpty {
                     Button(action: {
                        inputText = ""
                     }) {
                        Image(systemName: "xmark.circle.fill")
                           .foregroundColor(.gray)
                     }
                     .padding(.trailing)
                  }
               }
               
               Text("\(inputText.count)/\(characterLimit)")
                  .font(.caption)
                  .foregroundColor(inputText.count > characterLimit ? .red : .gray)
               
               Button(action: {
                  if inputText.isEmpty {
                     ipaOutput = ""
                     return
                  }
                  
                  guard let langCode = languageCodes[selectedLanguage] else {
                     print("Invalid language selection")
                     return
                  }
                  
                  hideKeyboard()
                  
                  translateText(inputText: inputText, languageCode: langCode) { ipa in
                     ipaOutput = ipa ?? "Translation failed"
                  }
               }) {
                  Text("Translate to IPA")
                     .frame(maxWidth: .infinity)
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(10)
               }
               .padding(.horizontal)
               
               VStack(alignment: .leading, spacing: 8) {
                  HStack {
                     Text("IPA Output:")
                        .font(.headline)
                     Spacer()
                     if !ipaOutput.isEmpty {
                        Button(action: {
                           UIPasteboard.general.string = ipaOutput
                        }) {
                           Image(systemName: "doc.on.doc")
                              .foregroundColor(.blue)
                        }
                     }
                  }
                  .padding(.horizontal, 20)
                  
                  SelectableTextView(text: ipaOutput.isEmpty ? "Translation" : ipaOutput)
                     .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 200, alignment: .leading)
                     .background(Color.gray.opacity(0.2))
                     .cornerRadius(10)
                     .padding(.horizontal, 20)
                     .contextMenu {
                        Button(action: {
                           UIPasteboard.general.string = ipaOutput
                        }) {
                           Text("Copy All")
                           Image(systemName: "doc.on.doc")
                        }
                     }
               }
               
               Spacer()
            }
            .navigationTitle("IPA Translator")
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
            .keyboardResponsive()
         }
      }
   }
}

#Preview {
   ContentView()  // Pass a constant binding for preview
}
