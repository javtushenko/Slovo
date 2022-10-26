//
//  MainUIConstatnts.swift
//  Slovo
//
//  Created by Николай Явтушенко on 04.09.2022.
//

import UIKit

public enum MainUIConstatnts {
    /// верхний отступ от границы экрана
    static var topInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 60
        case .iphone4:
            return 60
        case .iphone5:
            return 40
        case .iphone6:
            return 40
        case .iphone6plus:
            return 40
        case .iphoneX:
            return 60
        case .iphoneXR:
            return 60
        case .iphone12:
            return 50
        case .iphone12mini:
            return 50
        case .iphone12proMax:
            return 60
        }
    }

    /// нижний отступ от границы экрана
    static var bottomInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 50
        case .iphone4:
            return 50
        case .iphone5:
            return 10
        case .iphone6:
            return 10
        case .iphone6plus:
            return 10
        case .iphoneX:
            return 50
        case .iphoneXR:
            return 50
        case .iphone12:
            return 40
        case .iphone12mini:
            return 35
        case .iphone12proMax:
            return 50
        }
    }

    /// вертикальный отступ элементов друг от друга
    static var itemVerticalInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 15
        case .iphone4:
            return 15
        case .iphone5:
            return 10
        case .iphone6:
            return 10
        case .iphone6plus:
            return 15
        case .iphoneX:
            return 15
        case .iphoneXR:
            return 15
        case .iphone12:
            return 15
        case .iphone12mini:
            return 12
        case .iphone12proMax:
            return 15
        }
    }

    /// горизонтальный отступ нижних элементов друг от друга
    static var itemHorizontalInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 16
        case .iphone4:
            return 7
        case .iphone5:
            return 7
        case .iphone6:
            return 8
        case .iphone6plus:
            return 8
        case .iphoneX:
            return 16
        case .iphoneXR:
            return 16
        case .iphone12:
            return 16
        case .iphone12mini:
            return 16
        case .iphone12proMax:
            return 16
        }
    }

    /// горизонтальный отступ верхних элементов друг от друга
    static var topItemHorizontalInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 16
        case .iphone4:
            return 8
        case .iphone5:
            return 8
        case .iphone6:
            return 9
        case .iphone6plus:
            return 9
        case .iphoneX:
            return 15
        case .iphoneXR:
            return 15
        case .iphone12:
            return 15
        case .iphone12mini:
            return 6
        case .iphone12proMax:
            return 15
        }
    }

    /// размер элементов бонусов
    static var itemSizeBonusView: CGSize {
        switch Display.typeIsLike {
        case .unknown:
            return CGSize(width: 110, height: 60)
        case .iphone4:
            return CGSize(width: 30, height: 30)
        case .iphone5:
            return CGSize(width: 30, height: 30)
        case .iphone6:
            return CGSize(width: 40, height: 40)
        case .iphone6plus:
            return CGSize(width: 50, height: 50)
        case .iphoneX:
            return CGSize(width: 114, height: 60)
        case .iphoneXR:
            return CGSize(width: 114, height: 60)
        case .iphone12:
            return CGSize(width: 114, height: 60)
        case .iphone12mini:
            return CGSize(width: 110, height: 60)
        case .iphone12proMax:
            return CGSize(width: 114, height: 60)
        }
    }

    /// размер кошелька
    static var itemSizeValetView: CGSize {
        switch Display.typeIsLike {
        case .unknown:
            return CGSize(width: 110, height: 60)
        case .iphone4:
            return CGSize(width: 80, height: 30)
        case .iphone5:
            return CGSize(width: 80, height: 30)
        case .iphone6:
            return CGSize(width: 80, height: 40)
        case .iphone6plus:
            return CGSize(width: 80, height: 50)
        case .iphoneX:
            return CGSize(width: 160, height: 60)
        case .iphoneXR:
            return CGSize(width: 160, height: 60)
        case .iphone12:
            return CGSize(width: 140, height: 60)
        case .iphone12mini:
            return CGSize(width: 140, height: 60)
        case .iphone12proMax:
            return CGSize(width: 160, height: 60)
        }
    }

    /// размер серии побед
    static var itemWinStreakView: CGSize {
        switch Display.typeIsLike {
        case .unknown:
            return CGSize(width: 110, height: 60)
        case .iphone4:
            return CGSize(width: 70, height: 30)
        case .iphone5:
            return CGSize(width: 70, height: 30)
        case .iphone6:
            return CGSize(width: 80, height: 40)
        case .iphone6plus:
            return CGSize(width: 80, height: 50)
        case .iphoneX:
            return CGSize(width: 130, height: 60)
        case .iphoneXR:
            return CGSize(width: 130, height: 60)
        case .iphone12:
            return CGSize(width: 130, height: 60)
        case .iphone12mini:
            return CGSize(width: 130, height: 60)
        case .iphone12proMax:
            return CGSize(width: 130, height: 60)
        }
    }

    /// размер обучения
    static var itemSizeTutorialView: CGSize {
        switch Display.typeIsLike {
        case .unknown:
            return CGSize(width: 60, height: 60)
        case .iphone4:
            return CGSize(width: 30, height: 30)
        case .iphone5:
            return CGSize(width: 30, height: 30)
        case .iphone6:
            return CGSize(width: 40, height: 40)
        case .iphone6plus:
            return CGSize(width: 50, height: 50)
        case .iphoneX:
            return CGSize(width: 60, height: 60)
        case .iphoneXR:
            return CGSize(width: 60, height: 60)
        case .iphone12:
            return CGSize(width: 60, height: 60)
        case .iphone12mini:
            return CGSize(width: 60, height: 60)
        case .iphone12proMax:
            return CGSize(width: 60, height: 60)
        }
    }
}

public enum Price {
    /// цена бонуса лупы
    static let priseSearch: Int = 25

    /// цена бонуса бомбы
    static let priseBoom: Int = 25

    /// цена бонуса книги
    static let priseBook: Int = 90
}
