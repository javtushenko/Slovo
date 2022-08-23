//
//  InfoView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 18.08.2022.
//

import PureLayout
import UIKit

public protocol InfoViewDelegate: AnyObject {
    /// нажата кнопка внутри контента
    func infoView(
        _ view: InfoView,
        didTapContentButton identifier: String
    )

    /// нажато на бэкграунд
    func infoViewDidTapBackground(
        _ view: InfoView
    )
}

public final class InfoView: UIView {
    public private(set) var mainIdentifier: String = ""

    public weak var delegate: InfoViewDelegate?

    private var isConstraintsInstalled: Bool = false

    private let backgroundButton = UIButton.newAutoLayout()

    private let contentView = InfoContentView.newAutoLayout()

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

public extension InfoView {
    /// Установка
    func setup(viewModel: InfoViewModel) {
        setupConstraintsIfNeeded()
        mainIdentifier = viewModel.mainIdentifier
        backgroundColor = viewModel.backgroundColor.withAlphaComponent(0.6)
        contentView.setup(viewModel: viewModel.contentViewModel)
    }
}

extension InfoView: InfoContentViewDelegate {
    /// нажата кнопка
    public func infoContentView(
        _ view: InfoContentView,
        didTapButton identifier: String
    ) {
        delegate?.infoView(self, didTapContentButton: identifier)
    }
}

private extension InfoView {
    // Общий инициализатор
    func commonInit() {
        createViewHierarchy()
        addTargets()
        contentView.delegate = self
    }

    // Создать иерархию вью
    func createViewHierarchy() {
        addSubview(backgroundButton)
        addSubview(contentView)
    }

    // Установка констрейнтов
    func setupConstraintsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        isConstraintsInstalled = true
        backgroundButton.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdge(
            toSuperviewEdge: .leading,
            withInset: Constants.contentInset
        )
        contentView.autoPinEdge(
            toSuperviewEdge: .trailing,
            withInset: Constants.contentInset
        )
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

    // установка таргетов
    func addTargets() {
        backgroundButton.addTarget(
            self,
            action: #selector(onTapButton),
            for: .touchUpInside
        )
    }

    // нажата кнопка
    @objc func onTapButton() {
        delegate?.infoViewDidTapBackground(self)
    }
}

private extension InfoView {
    enum Constants {
        static let contentInset: CGFloat = {
            Display.isIPhone5 ? 16 : 32
        }()
    }
}
