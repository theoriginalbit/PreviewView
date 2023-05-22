//
//  ViewPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

/// A type that can be used to preview in Xcode a `UIView`.
///
/// ```swift
/// struct YourView_Previews: PreviewProvider {
///     static var previews: some View {
///         ViewPreview(YourView())
///             .previewLayout(.fixed(width: 375, height: 86))
///     }
/// }
/// ```
///
/// - Important: For the best possible previewing of a standalone view, you should set the `.previewLayout` values to be the expected in-app sizes of your view.
/// - SeeAlso: ``ViewControllerPreview``
@available(iOS 13, *)
public struct ViewPreview: UIViewRepresentable {
    /// The view being previewed.
    public let view: UIView

    /// Creates a view preview.
    ///
    /// - Returns: The initialized preview object.
    public init(_ view: UIView) {
        self.view = view
    }

    public func makeUIView(context: Context) -> some UIView { view }
    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
