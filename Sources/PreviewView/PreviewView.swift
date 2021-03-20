import SwiftUI

public struct PreviewView<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewControllerType

    public init(for viewController: ViewControllerType) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> ViewControllerType { viewController }
    public func updateUIViewController(_ viewController: ViewControllerType, context: Context) {}

    public func wrapInNavigationController(prefersLargeTitles: Bool = false) -> PreviewView<UINavigationController> {
        let controller = UINavigationController(rootViewController: viewController)
        controller.navigationBar.prefersLargeTitles = prefersLargeTitles
        return PreviewView<UINavigationController>(for: controller)
    }
}
