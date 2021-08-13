//
//  PreviewTabBarItem.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import UIKit

/// Represents an item that can be used by the ``TabBarControllerPreview``.
public protocol PreviewTabBarItem {
    /// Provides an instance of a view controller for use in the `UITabBarController`.
    var viewController: UIViewController { get }
}

extension ViewControllerPreview: PreviewTabBarItem {}

extension NavigationControllerPreview: PreviewTabBarItem {
    public var viewController: UIViewController { navigationController }
}

/// A lightweight placeholder for a non-active view controller that exists within a tab bar.
///
/// This can be used to acheive a preview that more closely represents the appearance in-app.
///
/// ```swift
/// TabBarControllerPreview {
///     PreviewBlankTabItem(title: "Dashboard", symbolNamed: "rectangle.3.offgrid")
/// }
/// ```
/// - Important: This tab item may not be visible when your canvas is in Live Preview mode.
public struct PreviewBlankTabItem: PreviewTabBarItem {
    /// The view controller that backs this placeholder in the tab bar controller preview.
    public let viewController: UIViewController

    /// Creates a placeholder preview tab item with a title and an image from a file or asset catalog.
    ///
    /// - Parameters:
    ///   - title: The title used on this item's generated `UITabBarItem`.
    ///   - image: The image used on this item's generated `UITabBarItem`.
    /// - Returns: The initialized preview object.
    public init(title: String, image: UIImage?) {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Intentionally blank"
        viewController.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        self.viewController = viewController
    }
}
