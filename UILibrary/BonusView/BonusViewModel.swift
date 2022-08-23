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

    init(backgroundColor: UIColor,
         title: String) {
        self.backgroundColor = backgroundColor
        self.title = title
    }
    
    var titleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 35,
            fontType: .bold,
            color: .white,
            alignment: .center,
            letterSpacing: -0.05,
            lineHeight: 38
        )
        return title.styleAll(generalStyle).attributedString
    }
}
