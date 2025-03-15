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

enum SpellingVariant: Codable {
   case bool(Bool)
   case string(String)
   
   init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if let boolValue = try? container.decode(Bool.self) {
         self = .bool(boolValue)
      } else if let stringValue = try? container.decode(String.self) {
         self = .string(stringValue)
      } else {
         throw DecodingError.typeMismatch(SpellingVariant.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Bool or String"))
      }
   }
   
   func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      switch self {
         case .bool(let value):
            try container.encode(value)
         case .string(let value):
            try container.encode(value)
      }
   }
}

struct TranslationResponse: Codable {
   let detected: String
   let ipa: String
   let lang: String
   let spelling: SpellingVariant
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
      if let error = error {
         print("Network error: \(error.localizedDescription)")
         completion(nil)
         return
      }
      
      guard let data = data else {
         print("No data received")
         completion(nil)
         return
      }
      
      do {
         let responseData = try JSONDecoder().decode(TranslationResponse.self, from: data)
         DispatchQueue.main.async {
            completion(responseData.ipa)
         }
      } catch {
         if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Status Code: \(httpResponse.statusCode)")
         }
         if let responseString = String(data: data, encoding: .utf8) {
            print("Response data as string: \(responseString)")
         }
         print("Failed to decode response: \(error.localizedDescription)")
         completion(nil)
      }
   }.resume()
}
