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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createKeys()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
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

        return CGSize(width: 34, height: 50)
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
