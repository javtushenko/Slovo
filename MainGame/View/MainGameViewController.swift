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

    /// Ячейка с побед подряд
    let winStreak: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()
    
    /// Ячейка обучением
    let tutorialView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()
    
    /// Ячейка с кошельком
    let valletView: BonusView = {
        let view = BonusView.newAutoLayout()
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
        setupTutorialView()
        presenter?.onViewDidLoad()
        view.backgroundColor = .slovoDarkBackground
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    /// настроить вьюху с кошельком
    func setupValetView(viewModel: BonusViewModel) {
        valletView.setup(viewModel: viewModel)
        valletView.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
    }
    
    /// Настроить вью с серией побед
    func setupWinStreakView(viewModel: BonusViewModel) {
        winStreak.setup(viewModel: viewModel)
        winStreak.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
    }
    
    /// Настроить вью кнопки туториала
    func setupTutorialView() {
        let model = BonusViewModel(backgroundColor: .slovoGray,
                       title: "?",
                       titleColor: .black)
        tutorialView.setup(viewModel: model)
        tutorialView.setCorners(radius: MainUIConstatnts.itemSizeBonusView.height/2)
        let touch = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapTutorial)
        )
        tutorialView.addGestureRecognizer(touch)
    }
    
    // обработка нажатия на туториал
    @objc func handleTapTutorial() {
        presenter?.onTapTutorial()
    }
    
}

extension MainGameViewController {
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }

        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        view.addSubview(keyboardVC.view)

        addChild(boardVC)
        boardVC.didMove(toParent: self)
        view.addSubview(boardVC.view)

        view.addSubview(winStreak)
        view.addSubview(valletView)
        view.addSubview(tutorialView)
        view.addSubview(bonusBombView)
        view.addSubview(bonusSearchView)
        view.addSubview(bonusBookView)
        
        view.addSubview(infoView)
        
        isViewHieararchyCreated = true
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        
        // задаем размеры
        valletView.autoSetDimensions(to: MainUIConstatnts.itemSizeValetView)
        tutorialView.autoSetDimensions(to: MainUIConstatnts.itemSizeTutorialView)
        bonusBombView.autoSetDimensions(to: MainUIConstatnts.itemSizeBonusView)
        bonusSearchView.autoSetDimensions(to: MainUIConstatnts.itemSizeBonusView)
        bonusBookView.autoSetDimensions(to: MainUIConstatnts.itemSizeBonusView)
        winStreak.autoSetDimensions(to: MainUIConstatnts.itemWinStreakView)
        
        // обучение
        tutorialView.autoPinEdge(toSuperviewEdge: .right, withInset: MainUIConstatnts.itemHorizontalInset)
        tutorialView.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
        
        // серия побед
        winStreak.autoPinEdge(toSuperviewEdge: .left, withInset: MainUIConstatnts.itemHorizontalInset)
        winStreak.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
        
        // кошелек
        valletView.autoPinEdge(.leading, to: .trailing, of: winStreak, withOffset: MainUIConstatnts.topItemHorizontalInset)
        valletView.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
        
        // игровое поле
        if Display.isFormfactorX {
            boardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
            boardVC.view.autoPinEdge(toSuperviewEdge: .leading)
            boardVC.view.autoPinEdge(.top, to: .bottom, of: bonusSearchView, withOffset: MainUIConstatnts.itemVerticalInset)
            boardVC.view.autoPinEdge(.bottom, to: .top, of: keyboardVC.view, withOffset: MainUIConstatnts.itemVerticalInset)
        } else {
            boardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
            boardVC.view.autoPinEdge(toSuperviewEdge: .leading)
            boardVC.view.autoPinEdge(.top, to: .bottom, of: bonusSearchView, withOffset: MainUIConstatnts.itemVerticalInset)
            boardVC.view.autoPinEdge(.bottom, to: .top, of: keyboardVC.view, withOffset: MainUIConstatnts.itemVerticalInset)
        }
        
        // клавиатура
        if Display.isFormfactorX {
            keyboardVC.view.autoSetDimension(.height, toSize: 160)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .leading)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .bottom, withInset: MainUIConstatnts.bottomInset)
        } else {
            keyboardVC.view.autoSetDimension(.height, toSize: 130)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .leading)
            keyboardVC.view.autoPinEdge(toSuperviewEdge: .bottom, withInset: MainUIConstatnts.bottomInset)
        }
        
        // бонусы в зависимости от размера экрана
        if Display.isFormfactorX {
            // профиль

            // бомба бонус
            bonusBombView.autoAlignAxis(toSuperviewAxis: .vertical)
            bonusBombView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: MainUIConstatnts.itemVerticalInset)
            // лупа бонус
            bonusSearchView.autoPinEdge(toSuperviewEdge: .left, withInset: MainUIConstatnts.itemHorizontalInset)
            bonusSearchView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: MainUIConstatnts.itemVerticalInset)
            // книга бонус
            bonusBookView.autoPinEdge(toSuperviewEdge: .right, withInset: MainUIConstatnts.itemHorizontalInset)
            bonusBookView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: MainUIConstatnts.itemVerticalInset)
        } else {
            // лупа бонус
            bonusSearchView.autoPinEdge(.left, to: .right, of: valletView, withOffset: MainUIConstatnts.itemHorizontalInset)
            bonusSearchView.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
            // бомба бонус
            bonusBombView.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
            bonusBombView.autoPinEdge(.left, to: .right, of: bonusSearchView, withOffset: MainUIConstatnts.itemHorizontalInset)
            // книга бонус
            bonusBookView.autoPinEdge(toSuperviewEdge: .top, withInset: MainUIConstatnts.topInset)
            bonusBookView.autoPinEdge(.left, to: .right, of: bonusBombView, withOffset: MainUIConstatnts.itemHorizontalInset)
        }
        
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
        DispatchQueue.main.async {
            self.boardVC.reloadData()
        }
    }
    
    /// обновить данные клавиатуры
    func updateKeyboard() {
        DispatchQueue.main.async {
            self.keyboardVC.reloadData()
        }
    }
}
