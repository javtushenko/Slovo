//
//  Key.swift
//  Slovo
//
//  Created by Николай Явтушенко on 03.07.2022.
//

import Foundation
import UIKit

public struct Key {
    var character: Character
    var backgroundColor: UIColor

    init(character: Character,
         backgroundColor: UIColor) {
        self.character = character
        self.backgroundColor = backgroundColor
    }
}
