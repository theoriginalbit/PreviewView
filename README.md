# PreviewView

Make use of SwiftUI previews for your UIKit controllers!

It's as simple as:
```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(for: YourViewController())
            .edgesIgnoringSafeArea(.all)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
```

If your view controller is meant to be displayed in a `UINavigationController` just add `.wrapInNavigationController()`

```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(for: YourViewController())
            .wrapInNavigationController()
            .edgesIgnoringSafeArea(.all)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
```

The `.wrapInNavigationController()` function accepts a single parameter `prefersLargeTitles` which allows you to also configure the navigation controller's `navigationBar.prefersLargeTitles` property; by default it will be set to `false`.

**PRO TIP:** Did you know that you can easily create multiple previews with a simple `ForEach` loop?
```swift
struct YourViewController_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11", "iPhone 8", "iPhone SE (1st generation)"], id: \.self) { deviceName in
            PreviewView(for: YourViewController())
                .edgesIgnoringSafeArea(.all)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
```
