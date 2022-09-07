//
//  MainGameViewController + Bonus.swift
//  Slovo
//
//  Created by Николай Явтушенко on 22.08.2022.
//

import UIKit

/// тип игровой подсказки
public enum helpType: String {
    case search = "search"
    case bomb = "bomb"
    case book = "book"
}

extension MainGameViewController {
    // настроить вьюху с подсказкой ЛУПА
    func setupBonusSearch() {
        bonusSearchView.setup(viewModel: .init(backgroundColor: .slovoGray, title: "🔎"))
        bonusSearchView.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
        let touch = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapBonusSearch)
        )
        bonusSearchView.addGestureRecognizer(touch)
    }

    // настроить вьюху с подсказкой БОМБА
    func setupBonusBomb() {
        bonusBombView.setup(viewModel: .init(backgroundColor: .slovoOrange, title: "💣"))
        bonusBombView.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
        let touch = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapBonusBomb)
        )
        bonusBombView.addGestureRecognizer(touch)
    }

    // настроить вьюху с подсказкой КНИГА
    func setupBonusBook() {
        bonusBookView.setup(viewModel: .init(backgroundColor: .slovoGreen, title: "📖"))
        bonusBookView.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
        let touch = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapBonusBook)
        )
        bonusBookView.addGestureRecognizer(touch)
    }
    
    // настроить вью с информацией о бонусе
    func setupInfoView(viewModel: InfoContentViewModel) {
        let model = InfoViewModel(contentViewModel: viewModel, accessibilityInfo: "")
        infoView.delegate = self
        infoView.setup(viewModel: model)
    }
    
    // обработка нажатия на бонус ЛУПА
    @objc func handleTapBonusSearch() {
        presenter?.onTapBonusSearch()
    }
    
    // обработка нажатия на бонус БОМБУ
    @objc func handleTapBonusBomb() {
        presenter?.onTapBonusBomb()
    }
    
    // обработка нажатия на бонус КНИГУ
    @objc func handleTapBonusBook() {
        presenter?.onTapBonusBook()
    }
}

extension MainGameViewController: InfoViewDelegate {
    /// нажата кнопка внутри контента
    func infoView(
        _ view: InfoView,
        didTapContentButton identifier: String
    ) {
        infoView.isHidden = true
        switch identifier {
        case helpType.search.rawValue:
            presenter?.onUseHelpSearch()
        case helpType.bomb.rawValue:
            presenter?.onUseHelpBomb()
        case helpType.book.rawValue:
            presenter?.onUseHelpBook()
        default:
            return
        }
    }

    /// нажато на бэкграунд
    func infoViewDidTapBackground(
        _ view: InfoView
    ) {
        infoView.isHidden = true
    }
}
