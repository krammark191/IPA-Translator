//
//  ContentView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/13/25.
//

import SwiftUI

struct ContentView: View {
   @State private var inputText: String = ""
   @State private var ipaOutput: String = ""
   @State private var selectedLanguage: String = "English"
   @State private var isDarkMode: Bool = false
   
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
   let characterLimit = 2000
   
   var body: some View {
      NavigationView {
         VStack(spacing: 20) {
            HStack {
               Picker("Select Language", selection: $selectedLanguage) {
                  ForEach(languages, id: \..self) { language in
                     Text(language)
                  }
               }
               .pickerStyle(MenuPickerStyle())
               
               Toggle(isOn: $isDarkMode) {
                  Text("Dark Mode")
               }
               .padding(.leading)
            }
            .padding()
            
            HStack {
               TextField(languagePlaceholders[selectedLanguage] ?? "Enter text to translate", text: $inputText, onEditingChanged: { _ in
                  if inputText.count > characterLimit {
                     inputText = String(inputText.prefix(characterLimit))
                  }
               })
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
               translateText(inputText: inputText, language: selectedLanguage) { ipa in
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
            
            Text("IPA Output:")
               .font(.headline)
            
            Text(ipaOutput.isEmpty ? "Your translated text will appear here." : ipaOutput)
               .padding()
               .frame(maxWidth: .infinity, minHeight: 100)
               .background(Color.gray.opacity(0.2))
               .cornerRadius(10)
               .padding(.horizontal)
            
            Spacer()
         }
         .navigationTitle("IPA Translator")
         .preferredColorScheme(isDarkMode ? .dark : .light)
      }
   }
}

#Preview {
    ContentView()
}
