> **Note**
> 
> The `#Preview` macro ([WWDC23 session](https://developer.apple.com/wwdc23/10252)) will supplant this library once you can set your Minimum Deployment to iOS 17 or higher.
>
> If you have a project on Xcode 14, or your Minimum Deployment target is set to as early as iOS 11, then this still may be the library you're looking for.

# PreviewView

Make use of SwiftUI previews for rapidly prototyping your `UIViewControllers` and `UIViews`!

The SwiftUI preview canvas is tied to a specific version of Xcode, not the the target OS version. This means you can make use of this utility even if you're not targeting iOS 13 or higher, as long as you're using Xcode 10 or higher.

## My iOS deployment target is below iOS 13

If you're targeting an iOS version earlier than iOS 13 then you may be get an error such as: 
```
Compiling failed: '__designTimeString(_:fallback:)' is only available in iOS 13.0 or newer
```
Other known variants may be:
- `__designTimeInteger(_:fallback:)`
- `__designTimeBoolean(_:fallback:)`
- `__designTimeFloat(_:fallback:)`

To solve this issue this library provides another target, `PreviewViewLegacyOSCompileFix`, which adds functions annotated with `@backDeployed(before:)` so these functions exist on versions earlier than iOS 13.

In addition the normal `import PreviewView` and `import SwiftUI` imports alongside your `PreviewProvider` you will need to add `import PreviewViewLegacyOSCompileFix` to ensure the back deployed functions are present.

Don't forget to mark your `PreviewProvider` with `@available(iOS 13, *)`.

## Installation

You can manually drop the files into your project, or take a look at Apple's documentation for [adding Swift Packages in Xcode](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

Adding this as a dependency on a Swift Package is **not** recommended as it will then force the dependency on anyone that consumes your library.

## Previewing a view

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(YourView())
            .previewLayout(.fixed(width: 375, height: 86))
    }
}
```

**Important:** Update the `previewLayout` values to be the typical size of your view.

## Previewing a view controller

### Standalone

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(YourViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
```

If you wish to test a custom `UINavigationController` you can do so with `ViewControllerPreview`.

```swift
struct YourNavigationController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(YourNavigationController())
            .edgesIgnoringSafeArea(.all)
    }
}
```

### Embedded in a `UINavigationController`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerPreview {
            YourViewController()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

The body content of the `NavigationControllerPreview` accepts an entire navigation stack, allowing your previews to show back bar button items, and even be navigatable in Live Preview.

```swift
struct DetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerPreview {
            ListViewController()
            DetailViewController()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

You can customise the navigation bar settings and toolbar settings of the navigation controller via the initializer parameters.

```swift
struct DetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerPreview(barStyle: .largeTitle, showsToolbar: true) {
            ListViewController()
            DetailViewController()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

### Embedded in a `UITabBarController`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerPreview {
            ViewControllerPreview(YourViewController())
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

Displaying a single tab would be weird, so to allow your previews to closely match your real app you can provide the other tabs within the body.

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerPreview {
            PreviewBlankTabItem(title: "First", image: UIImage(systemName: "capsule"))
            
            ViewControllerPreview(YourViewController())
            
            ViewControllerPreview(YourOtherViewController())
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

You can even embed your view controllers in a navigation controller to get the full in-app experience.

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerPreview {
            PreviewBlankTabItem(title: "First", image: UIImage(systemName: "capsule"))
            
            NavigationControllerPreview {
                YourViewController()
            }
            
            PreviewBlankTabItem(title: "Third", image: UIImage(systemName: "diamond"))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```
