//
//  BoardCell.swift
//  Slovo
//
//  Created by Николай Явтушенко on 28.06.2022.
//

import UIKit

class BoardCell: UICollectionViewCell {
    static let identifier = "BoardCell"

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
        backgroundColor = .slovoGray
    }

    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        contentView.addSubview(label)
    }

    private func setupConstrainstsIfNeeded() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Конфигурировать ячейку
    func configure(with letter: Key) {
        label.text = String(letter.character).uppercased()
    }
}
