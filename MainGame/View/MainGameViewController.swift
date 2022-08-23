//
//  MainGameViewController.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
// 

import UIKit

final class MainGameViewController: UIViewController {
	var presenter: MainGameViewToPresenterProtocol?

    /// Коллекция с кастомной клавиатурой
    var keyboardVC = {
        KeyboardView()
    }()

    /// Коллекция с ячейками для ввода
    var boardVC = {
        BoardView()
    }()

    /// первая ячейка с бонусом
    let bonusSearchView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let bonusBombView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let bonusBookView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let valletView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let profileView: ProfileView = {
        let view = ProfileView.newAutoLayout()
        return view
    }()
    
    /// Информационное вью о бонусе с кнопкой применения
    let infoView: InfoView = {
        let view = InfoView.newAutoLayout()
        view.isHidden = true
        return view
    }()

    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
        setupBonusSearch()
        setupBonusBomb()
        setupBonusBook()
        setupValetView()
        setupProfileView()
        presenter?.onViewDidLoad()
        view.backgroundColor = .slovoDarkBackground
    }

    // настроить вьюху с кошельком
    func setupValetView() {
        valletView.setup(viewModel: .init(backgroundColor: .slovoGreen, title: "648"))
        valletView.setCorners(radius: 30)
    }

    // настроить профиль вьюху
    func setupProfileView() {
        profileView.setup(viewModel: .init(backgroundColor: .slovoGreen, title: ""))
        profileView.setCorners(radius: 30)
        profileView.fireView.setCorners(radius: 30)
    }
}

extension MainGameViewController {
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }

        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)

        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)

        view.addSubview(valletView)
        view.addSubview(bonusBombView)
        view.addSubview(bonusSearchView)
        view.addSubview(bonusBookView)
        view.addSubview(profileView)
        
        view.addSubview(infoView)
        
        isViewHieararchyCreated = true
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }

        keyboardVC.view.autoSetDimension(.height, toSize: 250)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

        boardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        boardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        boardVC.view.autoSetDimension(.height, toSize: 565)
        boardVC.view.autoPinEdge(.bottom, to: .top, of: keyboardVC.collectionView, withOffset: -16)

        bonusBombView.autoAlignAxis(toSuperviewAxis: .vertical)
        bonusBombView.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)

        bonusSearchView.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)
        bonusSearchView.autoPinEdge(.trailing, to: .leading, of: bonusBombView, withOffset: -18)

        bonusBookView.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)
        bonusBookView.autoPinEdge(.leading, to: .trailing, of: bonusBombView, withOffset: 18)

        valletView.autoPinEdge(.trailing, to: .leading, of: bonusBombView, withOffset: -18)
        valletView.autoPinEdge(.bottom, to: .top, of: bonusSearchView, withOffset: -18)

        profileView.autoPinEdge(.trailing, to: .trailing, of: bonusBookView)
        profileView.autoPinEdge(.bottom, to: .top, of: bonusBookView, withOffset: -18)
        
        infoView.autoPinEdgesToSuperviewEdges()

        isConstraintsInstalled = true
    }
}

extension MainGameViewController: MainGameViewProtocol {
    /// показать вью с информацией о бонусе
    func showInfoView(viewModel: InfoContentViewModel) {
        setupInfoView(viewModel: viewModel)
        infoView.isHidden = false
    }

    /// обновить данные на игровом поле
    func updateGuesses() {
        boardVC.reloadData()
    }

    /// обновить данные клавиатуры
    func updateKeyboard() {
        keyboardVC.reloadData()
    }
}
