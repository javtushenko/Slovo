//
//  InfoContentView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 18.08.2022.
//

import PureLayout
import UIKit

public protocol InfoContentViewDelegate: AnyObject {
    /// нажата кнопка
    func infoContentView(
        _ view: InfoContentView,
        didTapButton identifier: String
    )
}

public final class InfoContentView: UIView {
    public private(set) var mainIdentifier: String = ""

    public weak var delegate: InfoContentViewDelegate?

    private var isConstraintsInstalled: Bool = false

    // Основной заголовок
    private let titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.numberOfLines = 0
        return label
    }()

    // Описание
    private let descriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.numberOfLines = 0
        return label
    }()

    // Кнопка
    private let button: UIButton = {
        let button = UIButton.newAutoLayout()
        return button
    }()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Обновление констрейнтов
    override public func updateConstraints() {
        setupConstraintsIfNeeded()
        super.updateConstraints()
    }
}

public extension InfoContentView {
    /// Установка
    func setup(viewModel: InfoContentViewModel) {
        setupConstraintsIfNeeded()
        titleLabel.attributedText = viewModel.titleAttributedText
        descriptionLabel.attributedText = viewModel.descriptionAttributedText
        mainIdentifier = viewModel.mainIdentifier
        backgroundColor = viewModel.backgroundColor
        setupButton(viewModel: viewModel)
        setCorners(radius: viewModel.cornerRadius)
    }
    
    /// Установить кнопку
    func setupButton(viewModel: InfoContentViewModel) {
        button.setAttributedTitle(viewModel.titleButtonAttributedText, for: .normal)
        button.isEnabled = viewModel.isButtonEnable
        button.setTitleColor(.black, for: .normal)
        if button.isEnabled {
            button.backgroundColor = .slovoGreen
        } else {
            button.backgroundColor = .slovoDark
        }
        button.setCorners(radius: 15)
    }
}

private extension InfoContentView {
    // Общий инициализатор
    func commonInit() {
        createViewHierarchy()
        addTargets()
    }

    // Создать иерархию вью
    func createViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(button)
    }

    // Установка констрейнтов
    func setupConstraintsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        isConstraintsInstalled = true

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 35)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 25)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 23)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)

        button.autoSetDimensions(to: CGSize(width: 110, height: 50))
        button.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 25)
        button.autoPinEdge(toSuperviewEdge: .bottom, withInset: 35)
        button.autoAlignAxis(toSuperviewMarginAxis: .vertical)
    }

    // установка таргетов
    func addTargets() {
        button.addTarget(
            self,
            action: #selector(onTapButton),
            for: .touchUpInside
        )
    }

    // нажата кнопка
    @objc func onTapButton() {
        delegate?.infoContentView(
            self,
            didTapButton: mainIdentifier
        )
    }
}
