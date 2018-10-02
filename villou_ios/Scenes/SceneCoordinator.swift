import UIKit
import RxSwift
import RxCocoa

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    @discardableResult
    func pop(animated: Bool) -> Completable
    @discardableResult
    func dismiss(animated: Bool) -> Completable
}

class SceneCoordinator: SceneCoordinatorType {

    private struct Time {
        static let fadeInOutDuration: TimeInterval = 0.3
    }

    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController

    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController!
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController()

        switch type {
        case let .root(animated):
            /*
                Calling this method on a view controller lower in the stack dismisses its immediate child view controller and all view controllers above that child on the stack.
            */
            window.rootViewController?.dismiss(animated: false, completion: nil)

            let setRootCompletion = { [weak self] in
                self?.currentViewController = SceneCoordinator.actualViewController(for: viewController)
                subject.onCompleted()
            }

            if animated, let snapshotView = window.snapshotView(afterScreenUpdates: true) {
                viewController.view.addSubview(snapshotView)
                window.rootViewController = viewController
                UIView.animate(withDuration: Time.fadeInOutDuration, animations: {
                    snapshotView.alpha = 0.0
                }) { _ in
                    snapshotView.removeFromSuperview()
                    setRootCompletion()
                }
            } else {
                window.rootViewController = viewController
                setRootCompletion()
            }

        case .push:
            guard let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            // one-off subscription to be notified when push complete
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            /*
             Note: You may question the memory safety of this construct because of the unbounded subscription to the navigation delegate proxy ^^. It’s totally safe: the returned observable will take at most one element, then complete. When completing, it disposes of its subscriptions. If nothing subscribes to the returned observable, the subject is disposed from memory and its subscriptions terminate as well.
             */
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = SceneCoordinator.actualViewController(for: viewController)

        case let .modal(style):
            viewController.modalTransitionStyle = style
            currentViewController.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        }
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }

    @discardableResult
    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        guard let navigationController = currentViewController.navigationController else {
            fatalError("No navigation controller: can't navigate back from \(currentViewController)")
        }
        // navigate up the stack
        // one-off subscription to be notified when pop complete
        _ = navigationController.rx.delegate
            .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
            .map { _ in }
            .bind(to: subject)
        guard navigationController.popViewController(animated: animated) != nil else {
            fatalError("can't navigate back from \(currentViewController)")
        }
        currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)

        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }

    @discardableResult
    func dismiss(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()

        guard let presenter = currentViewController.presentingViewController else {
            fatalError("Not a modal: can't navigate back from \(currentViewController)")
        }

        currentViewController.dismiss(animated: animated) {
            self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
            subject.onCompleted()
        }

        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }
}


