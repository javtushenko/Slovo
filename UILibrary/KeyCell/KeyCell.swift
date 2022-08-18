//
//  KeyCell.swift
//  Slovo
//
//  Created by Николай Явтушенко on 19.06.2022.
//

import UIKit
import PureLayout

class KeyCell: UICollectionViewCell {
    static let identifier = "KeyCell"

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        return label
    }()

    let image: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .slovoGray
        contentView.addSubview(label)
        contentView.addSubview(image)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        image.autoSetDimensions(to: CGSize(width: 30, height: 30))
        image.autoPinEdgesToSuperviewMargins()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(with letter: Character) {
        label.text = String(letter).uppercased()
        label.isHidden = false
        image.image = nil

        if letter == "+" {
            label.isHidden = true
            image.image = UIImage(named: "enter")
        }

        if letter == "-" {
            label.isHidden = true
            image.image = UIImage(named: "backspace")
        }
    }
}
