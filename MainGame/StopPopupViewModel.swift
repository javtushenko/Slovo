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
    var description: String
    var popupHeight: CGFloat
    var popupType: StopType

    init(title: String,
         subtitle: String,
         description: String,
         popupHeight: CGFloat,
         popupType: StopType) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.popupHeight = popupHeight
        self.popupType = popupType
    }

    var titleAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 40,
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
            size: 40,
            fontType: .bold,
            color: .black,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 40
        )
        return subtitle.styleAll(generalStyle).attributedString
    }

    var descriptionAttributedText: NSAttributedString {
        let generalStyle = Style.mainStyle(
            size: 16,
            fontType: .regular,
            color: .black,
            alignment: .center,
            letterSpacing: -0.25,
            lineHeight: 16
        )
        return description.styleAll(generalStyle).attributedString
    }
}
