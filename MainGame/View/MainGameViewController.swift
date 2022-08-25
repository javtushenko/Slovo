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
        view.isHidden = true
        return view
    }()
    
    /// Информационное вью о бонусе с кнопкой применения
    let infoView: InfoView = {
        let view = InfoView.newAutoLayout()
        view.isHidden = true
        return view
    }()
    
    /// верхний отступ от границы экрана
    var topInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 60
        case .iphone4:
            return 60
        case .iphone5:
            return 20
        case .iphone6:
            return 25
        case .iphone6plus:
            return 25
        case .iphoneX:
            return 60
        case .iphoneXR:
            return 60
        case .iphone12:
            return 50
        case .iphone12mini:
            return 50
        case .iphone12proMax:
            return 60
        }
    }
    
    // нижний отступ от границы экрана
    var bottomInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 50
        case .iphone4:
            return 50
        case .iphone5:
            return 5
        case .iphone6:
            return 5
        case .iphone6plus:
            return 5
        case .iphoneX:
            return 50
        case .iphoneXR:
            return 50
        case .iphone12:
            return 40
        case .iphone12mini:
            return 35
        case .iphone12proMax:
            return 50
        }
    }
    
    /// вертикальный отступ элементов друг от друга
    var itemVerticalInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 15
        case .iphone4:
            return 15
        case .iphone5:
            return 5
        case .iphone6:
            return 10
        case .iphone6plus:
            return 15
        case .iphoneX:
            return 15
        case .iphoneXR:
            return 15
        case .iphone12:
            return 15
        case .iphone12mini:
            return 12
        case .iphone12proMax:
            return 15
        }
    }
    
    // горизонтальный отступ элементов друг от друга
    var itemHorizontalInset: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 16
        case .iphone4:
            return 16
        case .iphone5:
            return 16
        case .iphone6:
            return 27
        case .iphone6plus:
            return 16
        case .iphoneX:
            return 16
        case .iphoneXR:
            return 16
        case .iphone12:
            return 16
        case .iphone12mini:
            return 16
        case .iphone12proMax:
            return 16
        }
    }
    
    // размер элементов
    var itemSize: CGSize {
        switch Display.typeIsLike {
        case .unknown:
            return CGSize(width: 110, height: 60)
        case .iphone4:
            return CGSize(width: 60, height: 30)
        case .iphone5:
            return CGSize(width: 60, height: 30)
        case .iphone6:
            return CGSize(width: 60, height: 40)
        case .iphone6plus:
            return CGSize(width: 82.5, height: 40)
        case .iphoneX:
            return CGSize(width: 114, height: 60)
        case .iphoneXR:
            return CGSize(width: 114, height: 60)
        case .iphone12:
            return CGSize(width: 114, height: 60)
        case .iphone12mini:
            return CGSize(width: 110, height: 60)
        case .iphone12proMax:
            return CGSize(width: 114, height: 60)
        }
    }

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
        valletView.setCorners(radius: itemSize.height/2)
    }

    // настроить профиль вьюху
    func setupProfileView() {
        profileView.setup(viewModel: .init(backgroundColor: .slovoGreen, title: ""))
        profileView.setCorners(radius: itemSize.height/2)
        profileView.fireView.setCorners(radius: itemSize.height/2)
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
        
        // задаем размеры
        valletView.autoSetDimensions(to: itemSize)
        bonusBombView.autoSetDimensions(to: itemSize)
        bonusSearchView.autoSetDimensions(to: itemSize)
        bonusBookView.autoSetDimensions(to: itemSize)
        
        // кошелек
        valletView.autoPinEdge(toSuperviewEdge: .left, withInset: itemHorizontalInset)
        valletView.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        
        // игровое поле
        boardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        boardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        boardVC.view.autoPinEdge(.top, to: .bottom, of: bonusSearchView, withOffset: itemVerticalInset)
        boardVC.view.autoPinEdge(.bottom, to: .top, of: keyboardVC.view, withOffset: itemVerticalInset)
        // клавиатура
        
        keyboardVC.view.autoSetDimension(.height, toSize: 160)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .bottom, withInset: bottomInset)
        
        // бонусы в зависимости от размера экрана
        if Display.isFormfactorX {
            // профиль
            profileView.autoPinEdge(.trailing, to: .trailing, of: bonusBookView)
            profileView.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
            // бомба бонус
            bonusBombView.autoAlignAxis(toSuperviewAxis: .vertical)
            bonusBombView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: itemVerticalInset)
            // лупа бонус
            bonusSearchView.autoPinEdge(toSuperviewEdge: .left, withInset: itemHorizontalInset)
            bonusSearchView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: itemVerticalInset)
            // книга бонус
            bonusBookView.autoPinEdge(toSuperviewEdge: .right, withInset: itemHorizontalInset)
            bonusBookView.autoPinEdge(.top, to: .bottom, of: valletView, withOffset: itemVerticalInset)
        } else {
            // лупа бонус
            bonusSearchView.autoPinEdge(.left, to: .right, of: valletView, withOffset: itemHorizontalInset)
            bonusSearchView.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
            // бомба бонус
            bonusBombView.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
            bonusBombView.autoPinEdge(.left, to: .right, of: bonusSearchView, withOffset: itemHorizontalInset)
            // книга бонус
            bonusBookView.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
            bonusBookView.autoPinEdge(.left, to: .right, of: bonusBombView, withOffset: itemHorizontalInset)
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
