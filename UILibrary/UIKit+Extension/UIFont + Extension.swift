//
//  UIFont + Extension.swift
//  Slovo
//
//  Created by Николай Явтушенко on 13.08.2022.
//

import UIKit
import Atributika

public extension Style {
    // Стиль, задающий основные параметры текста
    static func mainStyle(
        size: CGFloat,
        fontType: UIFont.Weight = .regular,
        color: UIColor? = nil,
        alignment: NSTextAlignment = .left,
        letterSpacing: Double? = nil,
        lineHeight: CGFloat? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        _ type: StyleType = .normal
    ) -> Style {
        let font = UIFont.mainFont(size: size, type: fontType)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        } else {
            paragraphStyle.minimumLineHeight = font.lineHeight
            paragraphStyle.maximumLineHeight = font.lineHeight
        }
        paragraphStyle.alignment = alignment
        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }
        var style = Style
            .font(font)
            .paragraphStyle(paragraphStyle)

        if let color = color {
            style = style.foregroundColor(color)
        }
        if let kern = letterSpacing {
            style = style.kern(Float(kern))
        }

        return style
    }
}

extension UIFont {
    // основной шрифт
    open class func mainFont(
        size: CGFloat,
        type: Weight = .regular
    ) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: type)
    }
}
