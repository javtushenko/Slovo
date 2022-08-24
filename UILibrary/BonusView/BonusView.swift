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
    
    // основная вьюха
    private let label: UILabel = {
        let view = UILabel.newAutoLayout()
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
        label.attributedText = viewModel.titleAttributedText
    }

    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }
        addSubview(mainView)
        mainView.addSubview(label)
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        mainView.autoPinEdgesToSuperviewEdges()
        label.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        if Display.isFormfactorX {
            label.autoPinEdge(toSuperviewMargin: .bottom, withInset: 0)
        } else {
            label.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        }
    }
}
