import SwiftUI

public struct Preview: View {
    public enum NavigationController {
        case none
        case wrap(prefersLargeTitles: Bool = false)
    }

    enum Content {
        case asViewController(UIViewController, NavigationController)
        case asView(UIView)
    }

    private let content: Content

    public init(for viewController: UIViewController, navigationControllerStyle: NavigationController = .none) {
        content = .asViewController(viewController, navigationControllerStyle)
    }

    public init(for view: UIView) {
        content = .asView(view)
    }

    @ViewBuilder
    public var body: some View {
        switch content {
        case let .asViewController(viewController, .none):
            _PreviewViewController(for: viewController)
                .edgesIgnoringSafeArea(.all)
        case let .asViewController(viewController, .wrap(prefersLargeTitles)):
            _PreviewViewController(for: viewController)
                .wrapInNavigationController(prefersLargeTitles: prefersLargeTitles)
                .edgesIgnoringSafeArea(.all)
        case let .asView(view):
            _PreviewView(for: view)
        }
    }
}

// MARK: - As UIViewController

private struct _PreviewViewController<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewControllerType

    init(for viewController: ViewControllerType) {
        self.viewController = viewController
    }

    func makeUIViewController(context: Context) -> ViewControllerType { viewController }
    func updateUIViewController(_ viewController: ViewControllerType, context: Context) {}

    func wrapInNavigationController(prefersLargeTitles: Bool = false) -> _PreviewViewController<UINavigationController> {
        let controller = UINavigationController(rootViewController: viewController)
        controller.navigationBar.prefersLargeTitles = prefersLargeTitles
        return _PreviewViewController<UINavigationController>(for: controller)
    }
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
