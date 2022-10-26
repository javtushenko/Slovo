//
//  KeyboardManager.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//

import PureLayout
import UIKit

public typealias PopupContentViewController = UIViewController &
    PopupViewControllerDelegate

extension Notification.Name {
    // попап полностью открылся
    static let onPopupFullOpen = Notification
        .Name(rawValue: "on_popup_full_open")
}

public protocol PopupViewControllerDelegate: UIGestureRecognizerDelegate {
    // получить высоту контента
    func getContentHeightForPopupController(
        _ popupController: PopupViewController
    ) -> CGFloat

    // Уведомляем делегатов об жесте
    func popupControllerGestureUpdateY(
        _ popupController: PopupViewController,
        state: UIGestureRecognizer.State
    )

    /// Popup закрылся
    func popupHidden(_ popupController: PopupViewController)
}

public protocol PopupViewProtocol: AnyObject {
    /// анимация при сворачивании
    func closeScreenWithAnimation(
        timeInterval: TimeInterval,
        isNeedNotifyDelegate: Bool,
        completion: (() -> Void)?
    )

    /// Установить контроллер для отображения
    func setupController(
        viewController: PopupContentViewController,
        completion: ((_ isSuccess: Bool) -> Void)?
    )
}

public extension PopupViewProtocol {
    /// анимация при сворачивании
    func closeScreenWithAnimation() {
        closeScreenWithAnimation(
            timeInterval: 0.3,
            isNeedNotifyDelegate: false,
            completion: nil
        )
    }

    /// анимация при сворачивании
    func closeScreenWithAnimation(completion: (() -> Void)?) {
        closeScreenWithAnimation(
            timeInterval: 0.3,
            isNeedNotifyDelegate: false,
            completion: completion
        )
    }

    /// Установить контроллер для отображения
    func setupController(viewController: PopupContentViewController) {
        setupController(viewController: viewController, completion: nil)
    }
}

extension PopupViewControllerDelegate {
    // Когда смахнули вниз или нажали на пустую область, чтобы закрыть (но ещё по факту не закрылся)
    public func didStartSwipeOrTapToDissmis(
        _ popupController: PopupViewController
    ) {
        // Пустая реализация по умолчанию
    }

    /// Пустая реализация по умолчанию
    public func popupControllerGestureUpdateY(
        _ popupController: PopupViewController,
        state: UIGestureRecognizer.State
    ) {}

    /// Popup закрылся
    public func popupHidden(_ popupController: PopupViewController) {}
}

open class PopupViewController: UIViewController, PopupViewProtocol {
    public let backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.alpha = 0.6
        return view
    }()

    public let darkBackgroundButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setTitle("", for: .normal)
        return button
    }()

    public let mainContentView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    public let contentView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    public let whiteView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    public let tongueView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    public let bottomView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    public let topBorderView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.slovoWhite
        return view
    }()

    // Прозрачность заднего фона
    public var backGroundAlphaContent: CGFloat = 0.5

    var contentViewHeightConstraint: NSLayoutConstraint!
    var safeAreaViewHeightConstraint: NSLayoutConstraint!
    var contentLeadingConstraint: NSLayoutConstraint!
    var contentTrailingConstraint: NSLayoutConstraint!
    var bottomViewLeadingConstraint: NSLayoutConstraint!
    var bottomViewTrailingConstraint: NSLayoutConstraint!

    public var isTongueShowed = false
    public var isNeedTopBorderShowed = false
    // swiftlint:disable weak_delegate
    public var delegate: PopupViewControllerDelegate?
    // swiftlint:enable weak_delegate
    public var panGestureRecognizer = UIPanGestureRecognizer()

    public var topOffsetMax: CGFloat = 40

    public var height: CGFloat = 0
    public var mainPosition: CGFloat = 0

    public var isNeedWhiteView = true
    public var colorForBorderView: UIColor = .white

    public var isPopupOpen: Bool = false

    public var isPopupClosed: Bool = false

    open weak var currentViewController: UIViewController?

    public var minValueForFullOpen: CGFloat?

    public var isFullOpenedPopup: Bool {
        mainPosition == 0
    }

    public var openingScreenSpringWithDamping: CGFloat = 0.8
    public var openingScreenInitialSpringVelocity: CGFloat = 0.8
    public var openingScreenDelay: TimeInterval = 0
    public var specialAnimationInterval: TimeInterval = 0
    public var animationInterval: TimeInterval {
        if self.height > 400 && mainPosition == 0 {
            return 0.6
        }
        return 0.4
    }

    open var isInterfaceOrientationPortrait: Bool = true

    override open func viewDidLoad() {
        super.viewDidLoad()
        createViewHierarchy()
        setupConstraints()

        setupConstraint()
        setupCorners()
        setupUI()
    }

    // Создать иерархию вью
    func createViewHierarchy() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(darkBackgroundButton)

        view.addSubview(tongueView)

        view.addSubview(mainContentView)
        mainContentView.addSubview(contentView)
        mainContentView.addSubview(whiteView)

        mainContentView.addSubview(topBorderView)

        view.addSubview(bottomView)
    }

    // установить констрейнты для tongueView
    private func setupTongueView() {
        tongueView.autoSetDimensions(to: CGSize(width: 38, height: 4))
        tongueView.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    // установить констрейнты для contentView
    private func setupContentView() {
        contentView.autoPinEdge(toSuperviewEdge: .top)
        contentView.autoPinEdge(toSuperviewEdge: .leading)
        contentView.autoPinEdge(toSuperviewEdge: .trailing)
    }

    // установить констрейнты для topBorderView
    private func setupTopBorderView() {
        topBorderView.autoPinEdge(toSuperviewEdge: .top)
        topBorderView.autoPinEdge(toSuperviewEdge: .leading)
        topBorderView.autoPinEdge(toSuperviewEdge: .trailing)
        topBorderView.autoSetDimension(.height, toSize: 2)
    }

    // установить констрейнты для whiteView
    private func setupWhiteView() {
        whiteView.autoPinEdge(toSuperviewEdge: .bottom)
        whiteView.autoPinEdge(toSuperviewEdge: .leading)
        whiteView.autoPinEdge(toSuperviewEdge: .trailing)
        NSLayoutConstraint.autoSetPriority(UILayoutPriority(999)) {
            safeAreaViewHeightConstraint = whiteView.autoSetDimension(
                .height,
                toSize: 0
            )
        }
        whiteView.autoPinEdge(.top, to: .bottom, of: contentView)
    }

    // установить констрейнты для bottomView
    private func setupBottomView() {
        bottomView.autoSetDimension(.height, toSize: 1_000)
        bottomView.autoPinEdge(
            .top,
            to: .bottom,
            of: mainContentView,
            withOffset: -1
        )
    }

    // установить нижнюю view
    private func setBottomView() {
        if isInterfaceOrientationPortrait {
            bottomViewLeadingConstraint = bottomView
                .autoPinEdge(toSuperviewEdge: .leading)
            bottomViewTrailingConstraint = bottomView
                .autoPinEdge(toSuperviewEdge: .trailing)
        } else {
            let inset = (
                UIScreen.main.bounds.width - UIScreen.main.bounds
                    .height
            ) / 2
            bottomViewLeadingConstraint = bottomView.autoPinEdge(
                toSuperviewEdge: .leading,
                withInset: inset
            )
            bottomViewTrailingConstraint = bottomView.autoPinEdge(
                toSuperviewEdge: .trailing,
                withInset: inset
            )
        }
    }

    // установить основное view контента
    private func setMainContentView() {
        mainContentView.autoPinEdge(toSuperviewEdge: .bottom)
        if isInterfaceOrientationPortrait {
            contentLeadingConstraint = mainContentView
                .autoPinEdge(toSuperviewEdge: .leading)
            contentTrailingConstraint = mainContentView
                .autoPinEdge(toSuperviewEdge: .trailing)
        } else {
            let minSide = min(
                UIScreen.main.bounds.width,
                UIScreen.main.bounds.height
            )
            let maxSide = max(
                UIScreen.main.bounds.width,
                UIScreen.main.bounds.height
            )
            let inset = (maxSide - minSide) / 2
            contentLeadingConstraint = mainContentView.autoPinEdge(
                toSuperviewEdge: .leading,
                withInset: inset
            )
            contentTrailingConstraint = mainContentView.autoPinEdge(
                toSuperviewEdge: .trailing,
                withInset: inset
            )
        }
        mainContentView.autoPinEdge(
            .top,
            to: .bottom,
            of: tongueView,
            withOffset: 8
        )
    }

    // Настроить констрейнты
    func setupConstraints() {
        backgroundView.autoPinEdgesToSuperviewEdges()
        darkBackgroundButton.autoPinEdgesToSuperviewEdges()

        // установить констрейнты для tongueView
        setupTongueView()

        // установить основное view контента
        setMainContentView()

        contentViewHeightConstraint = mainContentView.autoSetDimension(
            .height,
            toSize: 0
        )

        // установить констрейнты для contentView
        setupContentView()

        // установить констрейнты для topBorderView
        setupTopBorderView()

        // установить констрейнты для whiteView
        setupWhiteView()

        // установить констрейнты для bottomView
        setBottomView()

        // установить нижнюю view
        setupBottomView()
    }

    // установка таргетов
    func setupTargets() {
        darkBackgroundButton.addTarget(
            self,
            action: #selector(onTapDarkBackground(_:)),
            for: .touchUpInside
        )
    }

    override open func viewDidAppear(_ isAnimated: Bool) {
        super.viewDidAppear(false)
        DispatchQueue.main
            .asyncAfter(deadline: .now() + openingScreenDelay) { [weak self] in
                guard let self = self else { return }
                self.openScreenWithAnimation()
            }
    }

    // устанавливаем констрейнты
    open func setupConstraint() {
        // если есть пространство между super view и safe area, то выставляем белую вьюшку под таблицей
        let bottomPadding = view.safeAreaInsets.bottom
        if isNeedWhiteView {
            safeAreaViewHeightConstraint.constant = bottomPadding
        } else {
            safeAreaViewHeightConstraint.constant = 0
        }
    }

    // устанавливаем ui элементы
    func setupUI() {
        setupTongueUI()
        backgroundView.alpha = 0
    }

    // устанавливеем ui элементы для язычка
    func setupTongueUI() {
        tongueView.setCorners(radius: 2)
        tongueView.backgroundColor = .black
        tongueView.isHidden = true
    }

    // Спрятать язычок
    private func hideTongue(duration: TimeInterval = 0.4) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.tongueView.alpha = 0
        }, completion: { _ in
            self.tongueView.isHidden = true
        })
    }

    // устанавливаем закругления
    private func setupCorners() {
        let cornerRadius = 15
        mainContentView.layer.cornerRadius = CGFloat(cornerRadius)
        mainContentView.clipsToBounds = true
        mainContentView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }

    // добавляем распознавание жестов (свайпы)
    private func addPanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(onDragView)
        )
        panGestureRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = delegate
    }

    // обработка жестов
    @objc private func onDragView(
        gestureRecognizer: UIPanGestureRecognizer
    ) {
        let state = gestureRecognizer.state
        let transform = CGAffineTransform.identity

        switch state {
        case .began, .changed:
            let translation = gestureRecognizer.translation(in: view)
            let translationY = translation.y

            if translationY < 0 {
                var topPadding: CGFloat = 0

                if Display.isFormfactorX {
                    topPadding = view.safeAreaInsets.top
                    topPadding += 18
                }

                guard -translationY * 0.5 + height - mainPosition < UIScreen
                    .main.bounds.size.height - topOffsetMax - topPadding else {
                    return
                }
                mainContentView.transform = transform.translatedBy(
                    x: 0,
                    y: mainPosition + translationY * 0.5
                )
                tongueView.transform = transform.translatedBy(
                    x: 0,
                    y: mainPosition + translationY * 0.5
                )
                bottomView.transform = transform.translatedBy(
                    x: 0,
                    y: mainPosition + translationY * 0.5
                )
            } else {
                mainContentView.transform = transform.translatedBy(
                    x: 0,
                    y: mainPosition + translationY
                )
                tongueView.transform = transform.translatedBy(
                    x: 0,
                    y: mainPosition + translationY
                )
            }

        case .ended, .cancelled:
            handleEndedState(gestureRecognizer: gestureRecognizer)

        default:
            return
        }
        // Уведомляем делегат о состоянии жеста
        delegate?.popupControllerGestureUpdateY(self, state: state)
    }

    // когда отпустили
    open func handleEndedState(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        let translationY = translation.y
        // еcли быстрый саайп вниз
        if gestureRecognizer.velocity(in: view).y > 450 {
            closeScreenWithAnimation(isNeedNotifyDelegate: true)
            return
        }

        // решаем, нужно ли закрыть
        if translationY > height * 0.5 {
            closeScreenWithAnimation(isNeedNotifyDelegate: true)
        } else {
            if let minValueForFullOpen = minValueForFullOpen,
               mainPosition != 0,
               abs(translationY) < minValueForFullOpen {
                backToMainPositionWithAnamation()
                return
            }
            if translationY < 0 {
                setupOpenedStateWithAnamation()
            } else {
                backToTheMainStateWithAnamation()
                mainPosition = 0
            }
        }
    }

    // вернуть к мейн позиции с анимацией если попап не открыт на фул
    func backToMainPositionWithAnamation() {
        guard !isFullOpenedPopup else { return }
        let duration = animationInterval
        let transform = CGAffineTransform.identity
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: {
                self.mainContentView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
                self.tongueView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
                self.bottomView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
                self.view.layoutIfNeeded()
            }, completion: { _ in }
        )
    }

    // тапнули по темному фону
    @objc func onTapDarkBackground(_ sender: Any) {
        closeScreenWithAnimation(isNeedNotifyDelegate: true)
    }

    /// Установить контроллер для отображения
    open func setupController(
        viewController: PopupContentViewController,
        completion: ((_ isSuccess: Bool) -> Void)? = nil
    ) {
        _ = view
        delegate = viewController

        currentViewController = viewController

        if let subView = viewController.view {
            completion?(true)
            for subview in contentView.subviews {
                subview.removeFromSuperview()
            }
            contentView.addSubview(subView)
            subView.autoPinEdgesToSuperviewEdges()
        } else {
            completion?(false)
        }
        height = viewController.getContentHeightForPopupController(self)
        panGestureRecognizer.delegate = viewController
    }
}

// MARK: - Анимации
extension PopupViewController {
    // стартовая анимация (при разворачивании)
    private func openScreenWithAnimation() {
        guard !isPopupOpen else { return }
        setupConstraint()
        let transform = CGAffineTransform.identity
        tongueView.isHidden = !isTongueShowed
        topBorderView.isHidden = !isNeedTopBorderShowed
        backgroundView.backgroundColor = UIColor(hex: "04040A")
        contentViewHeightConstraint
            .constant = height + safeAreaViewHeightConstraint.constant
        mainContentView.transform = transform.translatedBy(x: 0, y: height)
        tongueView.transform = transform.translatedBy(x: 0, y: height)
        bottomView.transform = transform.translatedBy(x: 0, y: height)
        if mainPosition != 0 {
            mainPosition = height - mainPosition
        } else {
            NotificationCenter.default.post(
                name: Notification.Name.onPopupFullOpen,
                object: nil
            )
        }

        var defaultDuration: TimeInterval {
            specialAnimationInterval == 0 ? animationInterval :
            specialAnimationInterval
        }

        let animationDurationPopup = defaultDuration
        let animationDurationBackground = defaultDuration

        UIView.animate(withDuration: animationDurationBackground) {
            self.backgroundView.alpha = self.backGroundAlphaContent
        }

        UIView.animate(
            withDuration: animationDurationPopup,
            delay: 0,
            usingSpringWithDamping: openingScreenSpringWithDamping,
            initialSpringVelocity: openingScreenInitialSpringVelocity,
            options: .curveEaseOut, animations: {
                self.mainContentView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
                self.tongueView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
                self.bottomView.transform = transform.translatedBy(
                    x: 0,
                    y: self.mainPosition
                )
            }, completion: { _ in
                self.isPopupOpen = true
                self.addPanGestureRecognizer()
                self.setupTargets()
            }
        )
    }

    // анимация при сворачивании
    public func closeScreenWithAnimation(
        timeInterval: TimeInterval = 0.3,
        isNeedNotifyDelegate: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        isPopupClosed = true

        var animationDuration = timeInterval
        if height < 200 {
            animationDuration = 0.2
        }
        if specialAnimationInterval != 0 {
            animationDuration = 0.4
        }

        let animationDurationPopup = animationDuration
        let animationDurationBackground = animationDuration

        if isTongueShowed {
            hideTongue(duration: animationDuration)
        }

        view.endEditing(true)

        if isNeedNotifyDelegate {
            delegate?.didStartSwipeOrTapToDissmis(self)
        }

        let transform = CGAffineTransform.identity

        UIView
            .animate(withDuration: animationDurationBackground) { [weak self] in
                self?.backgroundView.alpha = 0
            }

        UIView.animate(
            withDuration: animationDurationPopup,
            delay: 0,
            options: .curveEaseOut, animations: {
                self.mainContentView.transform = transform.translatedBy(
                    x: 0,
                    y: self.height + self.safeAreaViewHeightConstraint.constant
                )
                self.tongueView.transform = transform.translatedBy(
                    x: 0,
                    y: self.height + self.safeAreaViewHeightConstraint.constant
                )
                self.bottomView.transform = transform.translatedBy(
                    x: 0,
                    y: self.height + self.safeAreaViewHeightConstraint.constant
                )
            }, completion: { _ in
                self.dismiss(animated: false, completion: { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.popupHidden(self)
                    completion?()
                })
            }
        )
    }

    // возвращаемся к основному состоянию с анимацией
    private func backToTheMainStateWithAnamation() {
        UIView.animate(
            withDuration: animationInterval,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.mainContentView.transform = .identity
                self?.tongueView.transform = .identity
                self?.bottomView.transform = .identity
            }
        )
    }

    // попап в развернутом виде
    public func setupOpenedStateWithAnamation() {
        // Проверяем есть ли у делегата собственное время анимации
        let duration = animationInterval
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: {
                self.mainContentView.transform = .identity
                self.tongueView.transform = .identity
                self.bottomView.transform = .identity
            }, completion: { [weak self] _ in
                // Ставим слабую ссылку потому что блок является @escaping
                self?.mainPosition = 0
                NotificationCenter.default.post(
                    name: Notification.Name.onPopupFullOpen,
                    object: nil
                )
            }
        )
    }
}
