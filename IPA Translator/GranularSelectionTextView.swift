//
//  GranularSelectionTextView.swift
//  IPA Translator
//
//  Created by Mark Van Horn on 3/17/25.
//


import UIKit
import SwiftUI
import Combine

class GranularSelectionTextView: UITextView {
   override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      if let longPress = gestureRecognizer as? UILongPressGestureRecognizer {
         if longPress.state == .began {
            let touchPoint = longPress.location(in: self)
            if let range = closestWordRange(at: touchPoint) {
               selectedRange = range
               becomeFirstResponder() // Ensure selection is active
               return true
            }
         }
      }
      return super.gestureRecognizerShouldBegin(gestureRecognizer)
   }
   
   private func closestWordRange(at point: CGPoint) -> NSRange? {
      // Get the closest text position to the touch point
      guard let textPosition = closestPosition(to: point) else { return nil }
      
      // Find the word range enclosing this position
      let wordRange = tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection.storage(.forward))
      
      // Convert UITextRange to NSRange
      guard let range = wordRange else { return nil }
      let start = offset(from: beginningOfDocument, to: range.start)
      let end = offset(from: beginningOfDocument, to: range.end)
      return NSRange(location: start, length: end - start)
   }
}

struct SelectableTextView: UIViewRepresentable {
   let text: String
   
   func makeUIView(context: Context) -> GranularSelectionTextView {
      let textView = GranularSelectionTextView()
      textView.isEditable = false
      textView.isSelectable = true
      textView.allowsEditingTextAttributes = false
      textView.text = text
      textView.font = .systemFont(ofSize: 16)
      textView.textColor = UIColor.label
      textView.backgroundColor = .clear
      textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
      textView.textContainer.lineBreakMode = .byWordWrapping
      textView.isScrollEnabled = true
      textView.isUserInteractionEnabled = true
      return textView
   }
   
   func updateUIView(_ uiView: GranularSelectionTextView, context: Context) {
      if uiView.text != text {
         uiView.text = text
         uiView.selectedTextRange = nil // Reset selection
      }
   }
}

struct KeyboardResponsiveModifier: ViewModifier {
   @State private var currentHeight: CGFloat = 0
   
   func body(content: Content) -> some View {
      content
         .padding(.bottom, currentHeight)
         .onReceive(Publishers.Merge(
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
               .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
               .map { $0.height },
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
               .map { _ in CGFloat(0) }
         )) { height in
            self.currentHeight = height
         }
   }
}

extension View {
   func keyboardResponsive() -> some View {
      self.modifier(KeyboardResponsiveModifier())
   }
}

extension View {
   func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}
