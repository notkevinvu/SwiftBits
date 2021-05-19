# Setting up a custom view
1) Create a custom view class.
  ```swift
  final class CustomView: UIView { }
  ```
  
2) Add the `init()` and `required init?(coder:)` methods for constructing the class. We can use `init()` like a `UIViewController`'s `viewDidLoad()` method to configure the view.

3) To preface this next part, I like to keep only UI/state properties and the inits in the original class. For example:
```swift
final class CustomView: UIView {
    // State properties
      
    // UI properties
      
    // init
}
```
We then create an extension of the view within the same file and add a `configure()` method to the extension. This allows us to compartmentalize our responsibilities (properties, inits, methods, etc).

```swift
extension CustomView {
    private func configure() {
        // setup view stuff and add subviews here
    }
}
```

4) Go back to the view controller you want to add the view to and add a variable to hold the view. `var contentView: UIView!`

5) If you don't have one yet, create a `setupView()` method and configure it like so:
```swift
private func setupView() {
    let customView = CustomView()
    // do any additional configuration of view if needed
    contentView = customView
    
    view = contentView
}
```

6) Call this method in the `loadView()` view lifecycle method:
```swift
override func loadView() {
    super.loadView()
    setupView()
}
```

 
 OPTIONAL FOR COLLECTION VIEW:
 
 7) Put collection view methods in an extension of the VC, which should conform to the `UICollectionViewFlowLayoutDelegate` and `UICollectionViewDataSource` protocols
 8) Remember to set the delegate and data source of the `contentView.collectionView` to self in the deck detail VC (i.e. the delegate/data source of the `CustomView`'s collectionView should be the corresponding view controller)
