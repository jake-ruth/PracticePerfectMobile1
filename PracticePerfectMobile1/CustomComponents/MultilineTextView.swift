//
//  CustomMultilineTextField.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/22/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import SwiftUI

public struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholderText = "Enter details..."

    public func makeUIView(context: UIViewRepresentableContext<MultilineTextView>) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.contentSize.height = 20
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        view.font = .systemFont(ofSize: 16)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5
        view.text = "Enter details..."
        view.textColor = .placeholderText
        return view
    }

    public func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultilineTextView>) {
        print("in fn")
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    public func makeCoordinator() -> MultilineTextView.Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextView
        
        init(_ parent: MultilineTextView){
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
}
 
