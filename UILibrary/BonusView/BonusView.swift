//
//  BonusView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 13.08.2022.
//

import UIKit
import PureLayout

public class BonusView: UIView {

    // основная вьюха
    private let mainView: UIView = {
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
    }

    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }
        addSubview(mainView)
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        mainView.autoSetDimensions(to: CGSize(width: 114, height: 60))
        mainView.autoPinEdgesToSuperviewEdges()
    }
}
