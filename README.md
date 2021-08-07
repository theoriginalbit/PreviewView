# PreviewView

Make use of SwiftUI previews for rapidly protyping your UIViewControllers and UIViews!

### Previewing a `UIView`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(for: YourView())
            .previewLayout(.fixed(width: 375, height: 86))
    }
}
```

Update the `previewLayout` values to be the typical size of your view.

### Previewing a `UIViewController`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(for: YourViewController())
    }
}
```

### Previewing a `UIViewController` embedded in a `UINavigationController`

#### With a standard navigation bar

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(navigationControllerFor: YourViewController())
    }
}
```

#### With a large title navigation bar

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(navigationControllerFor: YourViewController(), withNavigationBarStyle: .largeTitle)
    }
}
```

#### Without a navigation bar

Helpful when you may be using Live Preview and any other view controllers that are pushed from your view controller require a navigation bar.

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(navigationControllerFor: YourViewController(), withNavigationBarStyle: .none)
    }
}
```

### Previewing a `UIViewController` embedded in a `UITabBarController`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(tabBarControllerFor: YourViewController())
    }
}
```

You can also have the preview show the tab bar with other tab items <sup>1</sup>. By default your supplied view controller will be shown in the first position of the tab bar.

```swift
struct YourViewController_Previews: PreviewProvider {
    static let secondTabBarItem = UITabBarItem(title: "First",
                                               image: UIImage(systemName: "capsule"),
                                               selectedImage: UIImage(systemName: "capsule.fill"))

    static let thirdTabBarItem = UITabBarItem(title: "Third",
                                              image: UIImage(systemName: "diamond"),
                                              selectedImage: UIImage(systemName: "diamond.fill"))

    static var previews: some View {
        Preview(tabBarControllerFor: YourViewController(), withOtherTabs: secondTabBarItem, thirdTabBarItem)
    }
}
```

You can have it shown at any other position by providing a position index parameter. The following code the view controller will be shown in the second position.

```swift
struct YourViewController_Previews: PreviewProvider {
    static let firstTabBarItem = UITabBarItem(title: "First",
                                              image: UIImage(systemName: "capsule"),
                                              selectedImage: UIImage(systemName: "capsule.fill"))

    static let thirdTabBarItem = UITabBarItem(title: "Third",
                                              image: UIImage(systemName: "diamond"),
                                              selectedImage: UIImage(systemName: "diamond.fill"))

    static var previews: some View {
        Preview(tabBarControllerFor: YourViewController(), atPosition: 1, withOtherTabs: firstTabBarItem, thirdTabBarItem)
    }
}
```

### Pro Tip

Did you know that you can easily create multiple previews with a simple `ForEach` loop?

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11", "iPhone 8", "iPhone SE (1st generation)"], id: \.self) { deviceName in
            Preview(for: YourViewController())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
```
