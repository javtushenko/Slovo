//
//  ContentTutorialView.swift
//  Slovo
//
//  Created by Николай Явтушенко on 06.09.2022.
//

import UIKit

class ContentTutorialView: UIViewController {
    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false
    
    // точки
    let pageControl: UIPageControl = {
        UIPageControl.newAutoLayout()
    }()
    
    // основное изображение
    let mainImage: UIImageView = {
        UIImageView.newAutoLayout()
    }()

    var currentImage = UIImage()
    var currentPage = 0
    var numberOfPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDots()
        setupMainImage()
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
    }
    
    // Установить картинку
    func setupMainImage() {
        view.backgroundColor = .slovoDarkBackground
        mainImage.image = currentImage
        mainImage.contentMode = .scaleAspectFit
    }
    
    // Установить точки
    func setupDots() {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        pageControl.tintColor = .red
        pageControl.pageIndicatorTintColor = .slovoGray
        pageControl.currentPageIndicatorTintColor = .slovoOrange
    }
    
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }
        view.addSubview(mainImage)
        view.addSubview(pageControl)
        isViewHieararchyCreated = true
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        mainImage.autoPinEdgesToSuperviewEdges()
        pageControl.autoAlignAxis(toSuperviewAxis: .vertical)
        pageControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        isConstraintsInstalled = true
    }
}
