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
