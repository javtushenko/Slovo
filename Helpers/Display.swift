//
//  Display.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//

import UIKit

// типы дисплеев iPhone
public enum DisplayType {
    case unknown
    case iphone4
    case iphone5
    case iphone6
    case iphone6plus
    public static let iphone7 = iphone6
    public static let iphone7plus = iphone6plus
    case iphoneX
    case iphoneXR
    public static let iphoneXsMax = iphoneXR

    case iphone12
    case iphone12mini
    case iphone12proMax
}

public final class Display {
    public class var width: CGFloat { UIScreen.main.bounds.size.width }
    public class var height: CGFloat { UIScreen.main.bounds.size.height }
    public class var maxLength: CGFloat { max(width, height) }
    public class var minLength: CGFloat { min(width, height) }
    public class var isZoomed: Bool {
        UIScreen.main.nativeScale >= UIScreen.main.scale
    }

    public class var isRetina: Bool { UIScreen.main.scale >= 2.0 }
    public class var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    public class var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    public class var isCarplay: Bool {
        UIDevice.current.userInterfaceIdiom == .carPlay
    }

    public class var isTV: Bool { UIDevice.current.userInterfaceIdiom == .tv }
    public class var typeIsLike: DisplayType {
        if isPhone && maxLength < 568 {
            return .iphone4
        } else if isPhone && maxLength == 568 {
            return .iphone5
        } else if isPhone && maxLength == 667 {
            return .iphone6
        } else if isPhone && maxLength == 736 {
            return .iphone6plus
        } else if isPhone && maxLength == 812 {
            return .iphone12mini
        } else if isPhone && maxLength == 896 {
            return .iphoneXR
        } else if isPhone && maxLength == 844 {
            return .iphone12
        } else if isPhone && maxLength == 780 {
            return .iphone12mini
        } else if isPhone && maxLength == 926 {
            return .iphone12proMax
        }

        return .unknown
    }

    public class var isFormfactorX: Bool {
        if typeIsLike == .iphoneX ||
            typeIsLike == .iphoneXR ||
            typeIsLike == .unknown ||
            typeIsLike == .iphoneXsMax ||
            typeIsLike == .iphone12 ||
            typeIsLike == .iphone12mini ||
            typeIsLike == .iphone12proMax {
            return true
        } else {
            return false
        }
    }

    public class var isIPhone4: Bool { typeIsLike == .iphone4 }
    public class var isIPhone5: Bool { typeIsLike == .iphone5 }
    public class var isIPhone6: Bool { typeIsLike == .iphone6 }
    public class var isIPhone6plus: Bool { typeIsLike == .iphone6plus }
    public class var isIPhoneX: Bool { typeIsLike == .iphoneX }
    public class var isIPhoneXR: Bool { typeIsLike == .iphoneXR }

    public class var isIPhone12: Bool { typeIsLike == .iphone12 }
    public class var isIPhone12mini: Bool { typeIsLike == .iphone12mini }
    public class var isIPhone12proMax: Bool { typeIsLike == .iphone12proMax }
}
