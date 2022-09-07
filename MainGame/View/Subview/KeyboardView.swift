//
//  KeyboardView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 19.06.2022.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController(
        _ vc: KeyboardView,
        didTapKey letter: Character
    )
}

protocol KeyboardViewDatasource: AnyObject {
    func boxColor(at key: Character) -> UIColor
}

class KeyboardView: UIViewController {

    weak var delegate: KeyboardViewControllerDelegate?
    weak var datasource: KeyboardViewDatasource?

    let letters = ["йцукенгшщз-", "фывапролджэ", "ячсмитьбюх+"]
    var keys: [[Character]] = []

    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .clear
            collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
            return collectionView
    }()
    
    // ширина ячейки клавиатуры в зависимости от устройства
    var widthKey: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 34
        case .iphone4:
            return 34
        case .iphone5:
            return 27
        case .iphone6:
            return 31
        case .iphone6plus:
            return 34
        case .iphoneX:
            return 34
        case .iphoneXR:
            return 34
        case .iphone12:
            return 34
        case .iphone12mini:
            return 32
        case .iphone12proMax:
            return 35
        }
    }
    
    // высота ячейки клавиатуры в зависимости от устройства
    var heightKey: CGFloat {
        switch Display.typeIsLike {
        case .unknown:
            return 50
        case .iphone4:
            return 40
        case .iphone5:
            return 40
        case .iphone6:
            return 40
        case .iphone6plus:
            return 40
        case .iphoneX:
            return 50
        case .iphoneXR:
            return 50
        case .iphone12:
            return 50
        case .iphone12mini:
            return 50
        case .iphone12proMax:
            return 50
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createKeys()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // создаем буквы для клавиатуры
    func createKeys() {
        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }

    /// обновить данные клавиатуры (цвет и тд)
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension KeyboardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier,
                                                            for: indexPath) as? KeyCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        cell.backgroundColor = datasource?.boxColor(at: letter)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keys[section].count
    }
}

extension KeyboardView: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.count
    }
}

extension KeyboardView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthKey, height: heightKey)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 0,
            left: 5,
            bottom: 3,
            right: 5
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.keyboardViewController(self,
                                         didTapKey: letter)
    }
}
