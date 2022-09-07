//
//  StopPopupViewModel.swift
//  Slovo
//
//  Created by Николай Явтушенко on 13.08.2022.
//

import UIKit
import Atributika

public class StopPopupViewModel {
    var title: String
    var subtitle: String
    var titleButton: String
    var popupHeight: CGFloat
    var popupType: StopType

    init(title: String,
         subtitle: String,
         titleButton: String,
         popupHeight: CGFloat,
         popupType: StopType) {
        self.title = title
        self.subtitle = subtitle
        self.titleButton = titleButton
        self.popupHeight = popupHeight
        self.popupType = popupType
    }

    var titleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: Display.isFormfactorX ? 40 : 35,
            fontType: .bold,
            color: popupType == .win ? .slovoGreen : .slovoOrange,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 40
        )
        return title.styleAll(generalStyle).attributedString
    }

    var subTitleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: Display.isFormfactorX ? 38 : 30,
            fontType: .bold,
            color: .black,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 40
        )
        return subtitle.styleAll(generalStyle).attributedString
    }

    var titleButtonAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 20,
            fontType: .bold,
            color: .white,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 20
        )
        return titleButton.styleAll(generalStyle).attributedString
    }
}
