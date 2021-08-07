import SwiftUI

public struct Preview: View {
    enum Content {
        case asViewController(UIViewController)
        case asNavigationController(UIViewController, NavigationBarStyle)
        case asTabBarController(UIViewController, Int, [UITabBarItem])
        case asView(UIView)
    }

    private let content: Content

    public init(for viewController: UIViewController) {
        content = .asViewController(viewController)
    }

    public init(navigationControllerFor viewController: UIViewController, withNavigationBarStyle barStyle: NavigationBarStyle = .default) {
        content = .asNavigationController(viewController, barStyle)
    }

    public init(tabBarControllerFor viewController: UIViewController, atPosition position: Int = 0, withOtherTabs otherTabs: UITabBarItem...) {
        content = .asTabBarController(viewController, position, otherTabs)
    }

    public init(for view: UIView) {
        content = .asView(view)
    }

    @ViewBuilder
    public var body: some View {
        switch content {
        case let .asViewController(viewController):
            _PreviewViewController(for: viewController)
                .edgesIgnoringSafeArea(.all)
        case let .asNavigationController(viewController, barStyle):
            _PreviewNavigationController(embedding: viewController, withBarStyle: barStyle)
                .edgesIgnoringSafeArea(.all)
        case let .asTabBarController(viewController, position, otherTabs):
            _PreviewTabBarController(embedding: viewController, atPosition: position, withOtherTabs: otherTabs)
                .edgesIgnoringSafeArea(.all)
        case let .asView(view):
            _PreviewView(for: view)
        }
    }
}

public extension Preview {
    enum NavigationBarStyle {
        case none
        case `default`
        case largeTitle

        var prefersLargeTitles: Bool {
            self == .largeTitle
        }
    }
}

// MARK: - As UIViewController

private struct _PreviewViewController: UIViewControllerRepresentable {
    let viewController: UIViewController

    init(for viewController: UIViewController) {
        self.viewController = viewController
    }

    func makeUIViewController(context: Context) -> UIViewController { viewController }
    func updateUIViewController(_ viewController: UIViewController, context: Context) {}
}

// MARK: - As UINavigationController

private struct _PreviewNavigationController: UIViewControllerRepresentable {
    let navigationController: UINavigationController

    init(embedding viewController: UIViewController, withBarStyle barStyle: Preview.NavigationBarStyle) {
        let navigationController = UINavigationController(rootViewController: viewController)
        switch barStyle {
        case .default: break
        case .none:
            navigationController.setNavigationBarHidden(true, animated: false)
        case .largeTitle:
            navigationController.navigationBar.prefersLargeTitles = true
        }
        self.navigationController = navigationController
    }

    func makeUIViewController(context: Context) -> UINavigationController { navigationController }
    func updateUIViewController(_ viewController: UINavigationController, context: Context) {}
}

// MARK: - As UITabBarController

private struct _PreviewTabBarController: UIViewControllerRepresentable {
    let tabBarController: UITabBarController

    init(embedding viewController: UIViewController, atPosition position: Int, withOtherTabs otherTabs: [UITabBarItem]) {
        var viewControllers: [UIViewController] = otherTabs.map {
            let viewController = UIViewController()
            viewController.tabBarItem = $0
            return viewController
        }
        viewControllers.insert(viewController, at: position)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = position
        self.tabBarController = tabBarController
    }

    func makeUIViewController(context: Context) -> UITabBarController { tabBarController }
    func updateUIViewController(_ viewController: UITabBarController, context: Context) {}
}

// MARK: - As UIView

private struct _PreviewView<ViewType: UIView>: UIViewRepresentable {
    typealias UIViewType = ViewType

    let view: ViewType

    init(for view: ViewType) {
        self.view = view
    }

    func makeUIView(context: Context) -> ViewType { view }
    func updateUIView(_ uiView: ViewType, context: Context) {}
}
