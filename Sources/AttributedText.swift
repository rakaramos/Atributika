/**
 *  Atributika
 *
 *  Copyright (c) 2017 Pavel Sharanda. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation

public enum DetectionType {
    case tag(Tag)
    case range
}

public struct Detection {
    public let type: DetectionType
    public let style: Style
    public let range: Range<String.Index>
}

public protocol AttributedTextProtocol {
    var string: String { get }
    var detections: [Detection] { get }
//    var baseStyle: Style { get }
}

extension AttributedTextProtocol {
    
    private func makeAttributedString(baseStyle: Style, getAttributes: (Style)-> [NSAttributedStringKey: Any]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: getAttributes(baseStyle))
        
        for d in detections {
            let attrs = getAttributes(d.style)
            if attrs.count > 0 {
                attributedString.addAttributes(attrs, range: NSRange(d.range, in: string))
            }
        }
        
        return attributedString
    }
    
    public func attributedString(baseStyle: Style) -> NSAttributedString {
        return makeAttributedString(baseStyle: baseStyle) { $0.attributes }
    }
}

public struct AttributedText: AttributedTextProtocol {
    public var attributedString: NSAttributedString {
        return makeAttributedString { $0.attributes }
    }
    
    public let string: String
    public let detections: [Detection]
    public let baseStyle: Style
    
    init(string: String, detections: [Detection], baseStyle: Style) {
        self.string = string
        self.detections = detections
        self.baseStyle = baseStyle
    }
    
    private func makeAttributedString(getAttributes: (Style)-> [NSAttributedStringKey: Any]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: getAttributes(baseStyle))
        
        for d in detections {
            let attrs = getAttributes(d.style)
            if attrs.count > 0 {
                attributedString.addAttributes(attrs, range: NSRange(d.range, in: string))
            }
        }
        
        return attributedString
    }
    
    public func styleAll(_ style: Style) -> AttributedText {
        return AttributedText(string: string, detections: detections, baseStyle: baseStyle.merged(with: style))
    }
    
    public func style(range: Range<String.Index>, style: Style) -> AttributedText {
        let d = Detection(type: .range, style: style, range: range)
        return AttributedText(string: string, detections: detections + [d], baseStyle: baseStyle)
    }
}

extension String: AttributedTextProtocol {
    public var string: String {
        return self
    }
    
    public var detections: [Detection] {
        return []
    }
    
    public func style(baseStyle: Style = Style(), tags: [Style], transformers: [TagTransformer] = [.brTransformer], tuner: (Style, Tag) -> Style = { s, _ in return  s}) -> AttributedText {
        let (string, tagsInfo) = detectTags(transformers: transformers)
        
        var ds: [Detection] = []
        
        tagsInfo.forEach { t in
            
            if let style = (tags.first { style in style.name.lowercased() == t.tag.name.lowercased() }) {
                ds.append(Detection(type: .tag(t.tag), style: tuner(style, t.tag), range: t.range))
            } else {
                ds.append(Detection(type: .tag(t.tag), style: Style(), range: t.range))
            }
        }
        
        return AttributedText(string: string, detections: ds, baseStyle: baseStyle)
    }
    
    public func style(baseStyle: Style = Style(), tags: Style..., transformers: [TagTransformer] = [TagTransformer.brTransformer], tuner: (Style, Tag) -> Style = { s, _ in return  s}) -> AttributedText {
        return style(baseStyle: baseStyle, tags: tags, transformers: transformers, tuner: tuner)
    }
    
    public func styleAll(baseStyle: Style = Style(), _ style: Style) -> AttributedText {
        return AttributedText(string: string, detections: detections, baseStyle: baseStyle.merged(with: style))
    }
    
    public func style(range: Range<String.Index>, baseStyle: Style = Style(), style: Style) -> AttributedText {
        let d = Detection(type: .range, style: style, range: range)
        return AttributedText(string: string, detections: detections + [d], baseStyle: baseStyle)
    }
}

extension NSAttributedString: AttributedTextProtocol {
    
    public var detections: [Detection] {
        
        var ds: [Detection] = []
        
        enumerateAttributes(in: NSMakeRange(0, length), options: []) { (attributes, range, _) in
            if let range = Range(range, in: self.string) {
                ds.append(Detection(type: .range, style: Style("", attributes), range: range))
            }
        }
        
        return ds
    }
    
    public var baseStyle: Style {
        return Style()
    }
}
