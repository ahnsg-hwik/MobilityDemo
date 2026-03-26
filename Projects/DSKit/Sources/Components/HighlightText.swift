//
//  HighlightText.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/29/26.
//

import SwiftUI

public struct HighlightText: View {
    var text: String
    
    private var highlightText: String = ""
    private var baseFont : UIFont = .boldSystemFont(ofSize: 18)
    private var baseColor: UIColor = .black
    private var highlightFont: UIFont? = nil
    private var hightlightColor: UIColor? = nil
    
    private var attributedText: AttributedString { attributedString() }
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(attributedText)
    }
    
    private func attributedString() -> AttributedString {
        var attributedString = AttributedString(text)
        
        attributedString.font = baseFont
        attributedString.foregroundColor = baseColor

        if let range = attributedString.range(of: highlightText) {
            attributedString[range].font = highlightFont ?? baseFont
            attributedString[range].foregroundColor = hightlightColor ?? hightlightColor
        }
        
        return attributedString
    }

    public func base(font: UIFont, color: UIColor? = nil) -> Self {
        var new = self
        new.baseFont = font
        if let newColor = color { new.baseColor = newColor }
        return new
    }
    
    public func highlightText(_ text: String) -> Self {
        var new = self
        new.highlightText = text
        return new
    }
    
    public func highlight(font: UIFont? = nil, color: UIColor? = nil) -> Self {
        var new = self
        if let newFont = font { new.highlightFont = newFont }
        if let newColor = color { new.hightlightColor = newColor }
        return new
    }
}
