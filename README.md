# PreviewView

Make use of SwiftUI previews for rapidly protyping your `UIViewControllers` and `UIViews`!

## Important Note

The SwiftUI preview canvas is tied to a specific version of Xcode, not the the target OS version. This means you can make use of this utility even if you're not targetting iOS 13 or higher, as long as you're using Xcode 10 or higher.

If your application targets earlier than iOS 13 you will need to do is mark your `PreviewProvider` structs with an `@available(iOS 13, *)` attribute to ensure the app can still compile.

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
            PreviewBlankTabItem(title: "First", symbolNamed: "capsule")
            
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
            PreviewBlankTabItem(title: "First", symbolNamed: "capsule")
            
            NavigationControllerPreview {
                YourViewController()
            }
            
            PreviewBlankTabItem(title: "Third", symbolNamed: "diamond")
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

## Pro Tip

Did you know that you can easily create multiple previews with a simple `ForEach` loop?

```swift
struct YourViewController_Previews: PreviewProvider {
    static let supportedDevices = ["iPhone 11", "iPhone 8", "iPhone SE (1st generation)"]
    
    static var previews: some View {
        ForEach(Self.supportedDevices, id: \.self) { deviceName in
            ViewControllerPreview(YourViewController())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
```
