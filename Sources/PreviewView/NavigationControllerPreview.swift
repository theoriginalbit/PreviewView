//
//  NavigationControllerPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

/// A custom parameter attribute that constructs a navigation stack from a closure.
///
/// This is used by ``NavigationControllerPreview`` to provide a navigation stack. The last element in the navigation stack will be shown in the preview.
@resultBuilder public enum PreviewNavigationStackBuilder {
    public static func buildBlock(_ viewControllers: UIViewController...) -> [UIViewController] { viewControllers }
}

/// A type that can be used to preview in Xcode a `UIViewController` embedded within a `UINavigationController`.
///
/// If you wish to preview a custom `UINavigationController` you can use ``ViewControllerPreview``.
///
/// - SeeAlso: ``ViewControllerPreview``
/// - SeeAlso: ``TabBarControllerPreview``
public struct NavigationControllerPreview: UIViewControllerRepresentable {
    /// A style for displaying the navigation bar of this navigation controller.
    public enum NavigationBarStyle {
        /// Hides the navigation bar.
        case none

        /// Defers to the active view controller's navigation item for how the navigation bar should behave.
        case `default`

        /// Display a large title within an expanded navigation bar.
        case largeTitle
    }

    /// The navigation controller that is being previewed.
    public let navigationController: UINavigationController

    /// Creates a navigation controller preview that displays a view controller with the given bar styles.
    ///
    /// - Parameters:
    ///   - barStyle: The style to be applied to this navigation controller's `UINavigationBar`. The default value is ``NavigationBarStyle/default``.
    ///   - showsToolbar: Whether the navigation controller should show its `UIToolbar`. The default value is `false`.
    ///   - content: The view controllers of the navigation controller.
    /// - Returns: The initialized preview object.
    public init(barStyle: NavigationBarStyle = .default, showsToolbar: Bool = false, @PreviewNavigationStackBuilder _ content: () -> [UIViewController]) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = content()
        switch barStyle {
        case .default: break
        case .none: navigationController.isNavigationBarHidden = true
        case .largeTitle: navigationController.navigationBar.prefersLargeTitles = true
        }
        navigationController.isToolbarHidden = !showsToolbar
        self.navigationController = navigationController
    }

    public func makeUIViewController(context: Context) -> some UIViewController { navigationController }
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
