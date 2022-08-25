//
//  BoardView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 19.06.2022.
//

import UIKit

protocol BoardViewControllerDatasource: AnyObject {
    func getGuesses() -> [[Key?]]
    func boxColor(at indexPath: IndexPath)
}

class BoardView: UIViewController {

    weak var datasource: BoardViewControllerDatasource?

    public var isCanChangeColor: Bool = false
    public var currentSection: Int = 0

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.backgroundColor = .clear
        collectionVIew.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.identifier)
        return collectionVIew
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.autoPinEdge(toSuperviewEdge: .top)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
    }

    public func reloadData() {
        collectionView.reloadData()
    }
}

extension BoardView: UICollectionViewDelegateFlowLayout,
                     UICollectionViewDelegate,
                     UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.identifier, for: indexPath) as? BoardCell else {
            fatalError()
        }

        // меняем цвет только если можно
        if isCanChangeColor {
            // если текущая строка больше фактической то нельзя красить
            if indexPath.section < currentSection {
                datasource?.boxColor(at: indexPath)
            } else {
                isCanChangeColor = false
            }
        }

        let guesses = datasource?.getGuesses()
        cell.backgroundColor = guesses?[indexPath.section][indexPath.row]?.backgroundColor ?? .slovoGray

        if let letter = guesses?[indexPath.section][indexPath.row] {
            cell.configure(with: letter)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/5

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 2,
            left: 2,
            bottom: 2,
            right: 2
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
