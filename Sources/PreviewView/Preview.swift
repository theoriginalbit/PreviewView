import SwiftUI

public struct Preview: View {
    public enum NavigationController {
        case none
        case wrap(prefersLargeTitles: Bool = false)
    }

    public let body: AnyView

    public init(for viewController: UIViewController, navigationControllerStyle: NavigationController = .none) {
        let preview = PreviewController(for: viewController)

        switch navigationControllerStyle {
        case .none:
            body = AnyView(erasing: preview)
        case let .wrap(prefersLargeTitles):
            body = AnyView(erasing: preview.wrapInNavigationController(prefersLargeTitles: prefersLargeTitles))
        }
    }

    public init(for view: UIView) {
        body = AnyView(erasing: PreviewView(for: view))
    }
}

private struct PreviewController<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewControllerType

    init(for viewController: ViewControllerType) {
        self.viewController = viewController
    }

    func makeUIViewController(context: Context) -> ViewControllerType { viewController }
    func updateUIViewController(_ viewController: ViewControllerType, context: Context) {}

    func wrapInNavigationController(prefersLargeTitles: Bool = false) -> PreviewController<UINavigationController> {
        let controller = UINavigationController(rootViewController: viewController)
        controller.navigationBar.prefersLargeTitles = prefersLargeTitles
        return PreviewController<UINavigationController>(for: controller)
    }
}

private struct PreviewView<ViewType: UIView>: UIViewRepresentable {
    typealias UIViewType = ViewType

    let view: ViewType

    init(for view: ViewType) {
        self.view = view
    }

    func makeUIView(context: Context) -> ViewType { view }
    func updateUIView(_ uiView: ViewType, context: Context) {}
}
