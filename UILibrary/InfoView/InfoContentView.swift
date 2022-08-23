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
    
    func setupButton(viewModel: InfoContentViewModel) {
        button.setTitle(viewModel.titleButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .slovoGreen
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

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 32)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 17)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 23)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)

        button.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 23)
        button.autoSetDimensions(to: CGSize(width: 35, height: 35))
        button.autoPinEdgesToSuperviewEdges(
            with: .init(top: 0, left: 120, bottom: 32, right: 120),
            excludingEdge: .top
        )
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
            didTapButton: ""
        )
    }
}
