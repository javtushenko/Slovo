//
//  TutorialProtocols.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import UIKit

// MARK: View -
protocol TutorialViewProtocol: AnyObject {

}

// MARK: Presenter -
protocol TutorialViewToPresenterProtocol: AnyObject {
    /// Вью загружено
    func onViewDidLoad()
}

protocol TutorialInteractorToPresenterProtocol: AnyObject {
}

// MARK: Interactor -
protocol TutorialInteractorProtocol: AnyObject {
    /// запуск
    func start()
}

// MARK: Router -
protocol TutorialRouterProtocol: AnyObject {

}
