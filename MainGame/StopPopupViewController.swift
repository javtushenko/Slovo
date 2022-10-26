//
//  StopPopupViewController.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

final class StopPopupViewController: UIViewController {
	var presenter: StopPopupViewToPresenterProtocol?
    // попап
    weak var popup: PopupViewController?
    /// делегат
    var delegate: StopPopupViewDelegate?

    // тип попапа
    private var popupType: StopType?

    // Высота попапа
    private var popupHeight: CGFloat = 215

    // Максимальная высота попапа
    private let maxPopupHeight: CGFloat = 215

    // Заголовок попапа
    private let titleLable: UILabel = {
        UILabel.newAutoLayout()
    }()

    // Подзаголовок попапа
    private let subTitleLable: UILabel = {
        UILabel.newAutoLayout()
    }()

    // Описание попапа
    private let mainButton: UIButton = {
        let mainButton = UIButton.newAutoLayout()
        mainButton.backgroundColor = .slovoGreen
        return mainButton
    }()

    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
        presenter?.onViewDidLoad()
    }
}

extension StopPopupViewController: StopPopupViewProtocol {
    // установка вью
    func setup(viewModel: StopPopupViewModel) {
        popupHeight = viewModel.popupHeight
        popupType = viewModel.popupType
        titleLable.attributedText = viewModel.titleAttributedText
        subTitleLable.attributedText = viewModel.subTitleAttributedText
        mainButton.setAttributedTitle(viewModel.titleButtonAttributedText, for: .normal)
        mainButton.setCorners(radius: 15)
        addTargets()
    }
}

extension StopPopupViewController {
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else {
            print("❌ StopPopupViewController: иерархия вью уже создана")
            return
        }
        isViewHieararchyCreated = true
        view.addSubview(titleLable)
        view.addSubview(subTitleLable)
        view.addSubview(mainButton)
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else {
            print("❌ StopPopupViewController: констрейнты уже установлены")
            return
        }
        isConstraintsInstalled = true
        titleLable.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        titleLable.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        titleLable.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)

        subTitleLable.autoPinEdge(.top, to: .bottom, of: titleLable, withOffset: 10)
        subTitleLable.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        subTitleLable.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
//
        mainButton.autoPinEdge(.top, to: .bottom, of: subTitleLable, withOffset: 10)
        mainButton.autoSetDimensions(to: CGSize(width: 250, height: 50))
        mainButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
    }

    // установка таргетов
    func addTargets() {
        mainButton.addTarget(
            self,
            action: #selector(onTapButton),
            for: .touchUpInside
        )
    }

    // нажата кнопка
    @objc func onTapButton() {
        popup?.closeScreenWithAnimation()
    }
}

extension StopPopupViewController: PopupViewControllerDelegate {
    /// Высота попапа
    func getContentHeightForPopupController(_ popupController: PopupViewController) -> CGFloat {
        popupHeight
    }

    /// Popup закрылся
    func popupHidden(_ popupController: PopupViewController) {
        guard let popupType = popupType else {
            print("❌StopPopupViewController: нет popupType, метод делегата не сработал")
            return
        }
        delegate?.popupHidden(popupController, popupType: popupType)
    }
}
