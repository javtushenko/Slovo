//
//  BonusView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 13.08.2022.
//

import UIKit
import PureLayout

public class ProfileView: UIView {

    // основная вьюха
    private let scoreView: UIView = {
        let view = UIView.newAutoLayout()
        return view
    }()

    // основная вьюха
    public let fireView: UIView = {
        let view = UIView.newAutoLayout()
        return view
    }()

    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// устанавливаем вьюху
    public func setup(viewModel: BonusViewModel) {
        self.backgroundColor = viewModel.backgroundColor
        scoreView.backgroundColor = .slovoGray
        fireView.backgroundColor = .slovoOrange
    }

    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }
        addSubview(scoreView)
        scoreView.addSubview(fireView)
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }

        scoreView.autoSetDimensions(to: CGSize(width: 250, height: 60))
        scoreView.autoPinEdgesToSuperviewEdges()

        fireView.autoSetDimensions(to: CGSize(width: 150, height: 60))
        fireView.autoAlignAxis(toSuperviewAxis: .horizontal)
        fireView.autoPinEdge(toSuperviewEdge: .trailing)
    }
}
