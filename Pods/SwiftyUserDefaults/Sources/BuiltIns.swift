//
// SwiftyUserDefaults
//
// Copyright (c) 2015-present Radosław Pietruszewski, Łukasz Mróz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

extension DefaultsSerializable {
    public static var _defaultsArray: DefaultsArrayBridge<[T]> { DefaultsArrayBridge() }
}
extension Date: DefaultsSerializable {
    public static var _defaults: DefaultsObjectBridge<Date> { DefaultsObjectBridge() }
}
extension String: DefaultsSerializable {
    public static var _defaults: DefaultsStringBridge { DefaultsStringBridge() }
}
extension Int: DefaultsSerializable {
    public static var _defaults: DefaultsIntBridge { DefaultsIntBridge() }
}
extension Double: DefaultsSerializable {
    public static var _defaults: DefaultsDoubleBridge { DefaultsDoubleBridge() }
}
extension Bool: DefaultsSerializable {
    public static var _defaults: DefaultsBoolBridge { DefaultsBoolBridge() }
}
extension Data: DefaultsSerializable {
    public static var _defaults: DefaultsDataBridge { DefaultsDataBridge() }
}

extension URL: DefaultsSerializable {
    #if os(Linux)
    public static var _defaults: DefaultsKeyedArchiverBridge<URL> { DefaultsKeyedArchiverBridge() }
    #else
    public static var _defaults: DefaultsUrlBridge { DefaultsUrlBridge() }
    #endif
    public static var _defaultsArray: DefaultsKeyedArchiverBridge<[URL]> { DefaultsKeyedArchiverBridge() }
}

extension DefaultsSerializable where Self: Codable {
    public static var _defaults: DefaultsCodableBridge<Self> { DefaultsCodableBridge() }
    public static var _defaultsArray: DefaultsCodableBridge<[Self]> { DefaultsCodableBridge() }
}

extension DefaultsSerializable where Self: RawRepresentable {
    public static var _defaults: DefaultsRawRepresentableBridge<Self> { DefaultsRawRepresentableBridge() }
    public static var _defaultsArray: DefaultsRawRepresentableArrayBridge<[Self]> { DefaultsRawRepresentableArrayBridge() }
}

extension DefaultsSerializable where Self: NSCoding {
    public static var _defaults: DefaultsKeyedArchiverBridge<Self> { DefaultsKeyedArchiverBridge() }
    public static var _defaultsArray: DefaultsKeyedArchiverBridge<[Self]> { DefaultsKeyedArchiverBridge() }
}

extension Dictionary: DefaultsSerializable where Key == String {
    public typealias T = [Key: Value]
    public typealias Bridge = DefaultsObjectBridge<T>
    public typealias ArrayBridge = DefaultsArrayBridge<[T]>
    public static var _defaults: Bridge { Bridge() }
    public static var _defaultsArray: ArrayBridge { ArrayBridge() }
}
extension Array: DefaultsSerializable where Element: DefaultsSerializable {
    public typealias T = [Element.T]
    public typealias Bridge = Element.ArrayBridge
    public typealias ArrayBridge = DefaultsObjectBridge<[T]>
    public static var _defaults: Bridge {
        Element._defaultsArray
    }
    public static var _defaultsArray: ArrayBridge {
        fatalError("Multidimensional arrays are not supported yet")
    }
}

extension Optional: DefaultsSerializable where Wrapped: DefaultsSerializable {
    public typealias Bridge = DefaultsOptionalBridge<Wrapped.Bridge>
    public typealias ArrayBridge = DefaultsOptionalBridge<Wrapped.ArrayBridge>

    public static var _defaults: DefaultsOptionalBridge<Wrapped.Bridge> { DefaultsOptionalBridge(bridge: Wrapped._defaults) }
    public static var _defaultsArray: DefaultsOptionalBridge<Wrapped.ArrayBridge> { DefaultsOptionalBridge(bridge: Wrapped._defaultsArray) }
}
