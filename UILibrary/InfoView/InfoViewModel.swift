//
//  InfoViewModel.swift
//  Slovo
//
//  Created by Николай Явтушенко on 18.08.2022.
//

import Atributika
import UIKit

public class InfoViewModel {
    public let contentViewModel: InfoContentViewModel
    public let backgroundColor: UIColor

    public let mainIdentifier: String
    public let accessibilityInfo: String

    public init(
        contentViewModel: InfoContentViewModel,
        backgroundColor: UIColor = .black,
        mainIdentifier: String = "",
        accessibilityInfo: String
    ) {
        self.contentViewModel = contentViewModel
        self.backgroundColor = backgroundColor
        self.mainIdentifier = mainIdentifier
        self.accessibilityInfo = accessibilityInfo
    }
}
