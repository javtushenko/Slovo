//
//  TutorialPageController.swift
//  Slovo
//
//  Created by Николай Явтушенко on 06.09.2022.
//

import Foundation
import UIKit

class TutorialPageController: UIPageViewController {
    // контент слайдов
    let images: [UIImage?] = [UIImage(named: "tutorial_1"),
                              UIImage(named: "tutorial_2"),
                              UIImage(named: "tutorial_3")]
    
    // количество контента
    var contentCount: Int {
        images.count
    }
    
    init() {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .slovoDarkBackground
        dataSource = self
        if let contentViewController = showViewControllerAtIndex(0){
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentTutorialView? {
        guard index >= 0, index < contentCount else { return nil }
        let contentViewController = ContentTutorialView()
        contentViewController.currentPage = index
        contentViewController.numberOfPages = contentCount
        contentViewController.currentImage = images[index] ?? UIImage()
        return contentViewController
    }
}

extension TutorialPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentTutorialView).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentTutorialView).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
}
