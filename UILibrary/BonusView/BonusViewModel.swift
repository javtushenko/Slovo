//
//  BonusViewModel.swift
//  Slovo
//
//  Created by Николай Явтушенко on 13.08.2022.
//

import UIKit
import Atributika

public class BonusViewModel {
    var backgroundColor: UIColor
    var title: String
    var titleColor: UIColor

    init(backgroundColor: UIColor,
         title: String,
         titleColor: UIColor = .slovoWhite) {
        self.backgroundColor = backgroundColor
        self.title = title
        self.titleColor = titleColor
    }

    var titleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: Display.isFormfactorX ? 35 : 15,
            fontType: .bold,
            color: titleColor,
            alignment: .center,
            letterSpacing: -0.05,
            lineHeight: Display.isFormfactorX ? 38 : 17
        )
        return title.styleAll(generalStyle).attributedString
    }
}
