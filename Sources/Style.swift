//
//  Created by Pavel Sharanda on 21.02.17.
//  Copyright © 2017 psharanda. All rights reserved.
//

import UIKit

public struct Style {
    
    public let name: String
    
    public var attributes: [NSAttributedStringKey: Any] {
        return typedAttributes
    }
    
    public let typedAttributes: [NSAttributedStringKey: Any]
    
    public init(_ name: String = "", _ attributes: [NSAttributedStringKey: Any] = [:]) {
        self.name = name
        typedAttributes = attributes
    }
    
    public init(_ name: String, style: Style) {
        self.name = name
        self.typedAttributes = style.typedAttributes
    }
    
    public func named(_ name: String) -> Style {
        return Style(name, style: self)
    }
    
    public func merged(with style: Style) -> Style {
        var attrs = typedAttributes
        
        style.typedAttributes.forEach { key, value in
            attrs.updateValue(value, forKey: key)
        }
        
        return Style(name, attrs)
    }
    
    public func font(_ value: UIFont) -> Style {
        return merged(with: Style.font(value))
    }
    
    public func paragraphStyle(_ value: NSParagraphStyle) -> Style {
        return merged(with: Style.paragraphStyle(value))
    }
    
    public func foregroundColor(_ value: UIColor) -> Style {
        return merged(with: Style.foregroundColor(value))
    }
    
    public func backgroundColor(_ value: UIColor) -> Style {
        return merged(with: Style.backgroundColor(value))
    }
    
    public func ligature(_ value: Int) -> Style {
        return merged(with: Style.ligature(value))
    }
    
    public func kern(_ value: CGFloat) -> Style {
        return merged(with: Style.kern(value))
    }
    
    public func strikethroughStyle(_ value: NSUnderlineStyle) -> Style {
        return merged(with: Style.strikethroughStyle(value))
    }
    
    public func strikethroughColor(_ value: UIColor) -> Style {
        return merged(with: Style.strikethroughColor(value))
    }
    
    public func underlineStyle(_ value: NSUnderlineStyle) -> Style {
        return merged(with: Style.underlineStyle(value))
    }
    
    func underlineColor(_ value: UIColor) -> Style {
        return merged(with: Style.underlineColor(value))
    }
    
    public func strokeColor(_ value: UIColor) -> Style {
        return merged(with: Style.strokeColor(value))
    }
    
    public func strokeWidth(_ value: CGFloat) -> Style {
        return merged(with: Style.strokeWidth(value))
    }
    
    public func shadow(_ value: NSShadow) -> Style {
        return merged(with: Style.shadow(value))
    }
    
    public func textEffect(_ value: String) -> Style {
        return merged(with: Style.textEffect(value))
    }
    
    public func attachment(_ value: NSTextAttachment) -> Style {
        return merged(with: Style.attachment(value))
    }
    
    public func link(_ value: URL) -> Style {
        return merged(with: Style.link(value))
    }
    
    public func link(_ value: String) -> Style {
        return merged(with: Style.link(value))
    }
    
    public func baselineOffset(_ value: CGFloat) -> Style {
        return merged(with: Style.baselineOffset(value))
    }
    
    public func obliqueness(_ value: CGFloat) -> Style {
        return merged(with: Style.obliqueness(value))
    }
    
    public func expansion(_ value: CGFloat) -> Style {
        return merged(with: Style.expansion(value))
    }
    
    public func writingDirection(_ value: NSWritingDirection) -> Style {
        return merged(with: Style.writingDirection(value))
    }
    
    public static func font(_ value: UIFont) -> Style {
        return Style("", [.font: value])
    }
    
    public static func paragraphStyle(_ value: NSParagraphStyle) -> Style {
        return Style("", [.paragraphStyle: value])
    }
    
    public static func foregroundColor(_ value: UIColor) -> Style {
        return Style("", [.foregroundColor: value])
    }
    
    public static func backgroundColor(_ value: UIColor) -> Style {
        return Style("", [.backgroundColor: value])
    }
    
    public static func ligature(_ value: Int) -> Style {
        return Style("", [.ligature: value])
    }
    
    public static func kern(_ value: CGFloat) -> Style {
        return Style("", [.kern: value])
    }
    
    public static func strikethroughStyle(_ value: NSUnderlineStyle) -> Style {
        return Style("", [.strikethroughStyle : value.rawValue])
    }
    
    public static func strikethroughColor(_ value: UIColor) -> Style {
        return Style("", [.strikethroughColor: value])
    }
    
    public static func underlineStyle(_ value: NSUnderlineStyle) -> Style {
        return Style("", [.underlineStyle : value.rawValue])
    }
    
    public static func underlineColor(_ value: UIColor) -> Style {
        return Style("", [.underlineColor: value])
    }
    
    public static func strokeColor(_ value: UIColor) -> Style {
        return Style("", [.strokeColor: value])
    }
    
    public static func strokeWidth(_ value: CGFloat) -> Style {
        return Style("", [.strokeWidth: value])
    }
    
    public static func shadow(_ value: NSShadow) -> Style {
        return Style("", [.shadow: value])
    }
    
    public static func textEffect(_ value: String) -> Style {
        return Style("", [.textEffect: value])
    }
    
    public static func attachment(_ value: NSTextAttachment) -> Style {
        return Style("", [.attachment: value])
    }
    
    public static func link(_ value: URL) -> Style {
        return Style("", [.link: value])
    }
    
    public static func link(_ value: String) -> Style {
        return Style("", [.link: value])
    }
    
    public static func baselineOffset(_ value: CGFloat) -> Style {
        return Style("", [.baselineOffset: value])
    }
    
    public static func obliqueness(_ value: CGFloat) -> Style {
        return Style("", [.obliqueness: value])
    }
    
    public static func expansion(_ value: CGFloat) -> Style {
        return Style("", [.expansion: value])
    }
    
    public static func writingDirection(_ value: NSWritingDirection) -> Style {
        return Style("", [.writingDirection: value.rawValue])
    }
}
