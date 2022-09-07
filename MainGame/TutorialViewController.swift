//
//  TutorialViewController.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import UIKit

final class TutorialViewController: UIViewController {
	var presenter: TutorialViewToPresenterProtocol?
    weak var popup: PopupViewController?
    
    // Высота попапа
    private var popupHeight: CGFloat = Display.isFormfactorX ? 700 : 500

    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false
    
    let mainView: UIPageViewController = {
        TutorialPageController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .slovoDarkBackground
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
        presenter?.onViewDidLoad()
    }
}

extension TutorialViewController: TutorialViewProtocol {
}

extension TutorialViewController {
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }
        isViewHieararchyCreated = true
        
        addChild(mainView)
        mainView.didMove(toParent: self)
        view.addSubview(mainView.view)
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }
        isConstraintsInstalled = true
        
        mainView.view.autoPinEdgesToSuperviewEdges()
    }
}

extension TutorialViewController: PopupViewControllerDelegate {
    /// Высота попапа
    func getContentHeightForPopupController(_ popupController: PopupViewController) -> CGFloat {
        return popupHeight
    }
}
