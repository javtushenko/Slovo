//
//  InfoContentViewModel.swift
//  Slovo
//
//  Created by Николай Явтушенко on 18.08.2022.
//

import Atributika
import UIKit

public class InfoContentViewModel {
    public let title: String
    public let description: String
    public let titleButton: String
    public let backgroundColor: UIColor
    public let cornerRadius: CGFloat
    public let mainIdentifier: String
    public let accessibilityInfo: String

    public var titleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 50,
            fontType: .bold,
            color: .black,
            alignment: .center,
            letterSpacing: -0.05,
            lineHeight: 50
        )
        return title.styleAll(generalStyle).attributedString
    }
    
    public var descriptionAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 16,
            fontType: .regular,
            color: .slovoWhite,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 16
        )
        return description.styleAll(generalStyle).attributedString
    }

    public init(
        title: String,
        description: String,
        titleButton: String,
        backgroundColor: UIColor = .slovoDarkBackground,
        cornerRadius: CGFloat = 5,
        mainIdentifier: String = "",
        accessibilityInfo: String
    ) {
        self.title = title
        self.description = description
        self.titleButton = titleButton
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.mainIdentifier = mainIdentifier
        self.accessibilityInfo = accessibilityInfo
    }
}
