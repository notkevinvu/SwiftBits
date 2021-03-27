//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    
    // MARK: - Properties
    var contentView: TestView!
    
    var modelArrayOne: [TestModel] = [
        TestModel(title: "One"),
        TestModel(title: "Two"),
        TestModel(title: "Three"),
        TestModel(title: "Four"),
        TestModel(title: "Five")
    ]
    
    var modelArrayTwo: [TestModel] = [
        TestModel(title: "Six"),
        TestModel(title: "Seven"),
        TestModel(title: "Eight"),
        TestModel(title: "Nine"),
        TestModel(title: "Ten")
    ]
    
    // MARK: - View lifecycle
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Setup
    private func setupView() {
        let view = TestView()
        contentView = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = ViewController()

