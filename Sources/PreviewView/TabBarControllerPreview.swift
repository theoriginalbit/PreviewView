//
//  TabBarControllerPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

/// A custom parameter attribute that constructs a tab bar from a closure.
///
/// This is used by ``TabBarControllerPreview`` to provide an ordered list of tab bar items.
@resultBuilder public enum PreviewTabBarBuilder {
    public static func buildBlock(_ items: PreviewTabBarItem...) -> [UIViewController] { items.map(\.viewController) }
}

/// A type that can be used to preview in Xcode a `UIViewController` embedded within a `UITabBarController`.
///
/// - SeeAlso: ``ViewControllerPreview``
/// - SeeAlso: ``NavigationControllerPreview``
public struct TabBarControllerPreview: UIViewControllerRepresentable {
    public let tabBarController: UITabBarController

    /// Creates a tab bar controller preview that displays a view controller at the given position.
    ///
    /// - Parameters:
    ///   - selectedIndex: The index within the content closure which locates the element requiring previewing. The default value is `0`.
    ///   - content: The view controllers of the tab bar controller.
    /// - Returns: The initialized preview object.
    public init(selectedIndex: Int = 0, @PreviewTabBarBuilder _ content: () -> [UIViewController]) {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = content()
        tabBarController.selectedIndex = selectedIndex
        self.tabBarController = tabBarController
    }

    public func makeUIViewController(context: Context) -> some UIViewController { tabBarController }
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
