//
//  LoginWelcomeInfoCoordinator.swift
//  Slovo
//
//  Created by Николай Явтушенко on 19.08.2022.
//

import UIKit

protocol LoginWelcomeInfoCoordinatorProtocol: AnyObject {
    /// Запуск координатора
    func start()
    /// Закрыть координатор
    func cancel()
}

protocol LoginWelcomeInfoCoordinatorDelegate: AnyObject {
    /// Координатор завершил свою работу
    func loginWelcomeInfoCoordinatorDidFinish(
        _ coordinator: LoginWelcomeInfoCoordinatorProtocol
    )
}

final class LoginWelcomeInfoCoordinator {
    var rootViewController: UIViewController

    weak var delegate: LoginWelcomeInfoCoordinatorDelegate?

    init(
        delegate: LoginWelcomeInfoCoordinatorDelegate?,
        rootViewController: UIViewController
    ) {
        self.delegate = delegate
        self.rootViewController = rootViewController
    }
}

extension LoginWelcomeInfoCoordinator: LoginWelcomeInfoCoordinatorProtocol {
    /// Запуск координатора
    func start() {
        let viewController = WelcomeInfoViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .overFullScreen
        rootViewController.present(viewController, animated: true) {
            viewController.showInfoView()
        }
    }

    /// Закрыть координатор
    func cancel() {
        // Чтобы скрыть контроллер, проверяем что именно он сейчас отображается, иначе можно закрыть другой экран
        if isPresentedWelcome() {
            rootViewController.dismiss(animated: false)
        }
    }
}

extension LoginWelcomeInfoCoordinator: WelcomeInfoViewDelegate {
    /// контроллер завершил работу
    func welcomeInfoViewDidFinish(
        _ view: WelcomeInfoViewController
    ) {
        delegate?.loginWelcomeInfoCoordinatorDidFinish(self)
    }
}

private extension LoginWelcomeInfoCoordinator {
    /// Отображается ли сейчас  приветственный экран
    func isPresentedWelcome() -> Bool {
        // Достаем presentedViewController
        let viewController = rootViewController.presentedViewController
        guard let viewController = viewController else {
            return false
        }

        let isWelcome = viewController is WelcomeInfoViewController

        return isWelcome
    }
}
