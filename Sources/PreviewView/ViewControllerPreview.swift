//
//  ViewControllerPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

/// A type that can be used to preview in Xcode a `UIViewController`.
///
/// ```swift
/// struct YourViewController_Previews: PreviewProvider {
///     static var previews: some View {
///         ViewControllerPreview(YourViewController())
///     }
/// }
/// ```
///
/// - SeeAlso: ``NavigationControllerPreview``
/// - SeeAlso: ``TabBarControllerPreview``
@available(iOS 13, *)
public struct ViewControllerPreview: UIViewControllerRepresentable {
    /// The view controller being previewed.
    public let viewController: UIViewController

    /// Creates a view controller preview.
    ///
    /// - Returns: The initialized preview object.
    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> some UIViewController { viewController }
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
