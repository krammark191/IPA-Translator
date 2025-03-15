//
//  APIService.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/14/25.
//

import Foundation

struct TranslationRequest: Codable {
   let text: String
   let lang: String
   let mode: Bool
}

struct TranslationResponse: Codable {
   let detected: String
   let ipa: String
   let lang: String
   let spelling: String
}

func translateText(inputText: String, languageCode: String, completion: @escaping (String?) -> Void) {
   guard let url = URL(string: "https://api2.unalengua.com/ipav3") else {
      print("Invalid URL")
      completion(nil)
      return
   }
   
   let requestData = TranslationRequest(text: inputText, lang: languageCode, mode: true)
   
   guard let jsonData = try? JSONEncoder().encode(requestData) else {
      print("Failed to encode request data")
      completion(nil)
      return
   }
   
   var request = URLRequest(url: url)
   request.httpMethod = "POST"
   request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
   request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
   request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
   request.httpBody = jsonData
   
   URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
         print("Network error: \(error?.localizedDescription ?? "Unknown error")")
         completion(nil)
         return
      }
      
      do {
         let responseData = try JSONDecoder().decode(TranslationResponse.self, from: data)
         DispatchQueue.main.async {
            completion(responseData.ipa)
         }
      } catch {
         print("Failed to decode response: \(error.localizedDescription)")
         completion(nil)
      }
   }.resume()
}
