# PreviewView

Make use of SwiftUI previews for rapidly protyping your UIViewControllers and UIViews!

### Previewing a UIViewController

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(for: YourViewController())
            .edgesIgnoringSafeArea(.all)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
```

If your view controller is meant to be displayed in a `UINavigationController` there is a second parameter to adjust the navigation controller style; it can be either `.none` or `.wrap(prefersLargeTitles:)`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(for: YourViewController(), navigationControllerStyle: .wrap(prefersLargeTitles: true))
            .edgesIgnoringSafeArea(.all)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
```

### Previewing a UIView

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        Preview(for: YourView())
            .previewLayout(.fixed(width: 375, height: 86))
    }
}
```

Update the `previewLayout` values to be the typical size of your view.

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
