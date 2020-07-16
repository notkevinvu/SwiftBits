import UIKit

let viewController = UIViewController()
let destinationVC = UIViewController()

let transition = CATransition()
transition.duration = 0.3
transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
transition.type = CATransitionType.moveIn
transition.subtype = CATransitionSubtype.fromTop
viewController.navigationController?.view.layer.add(transition, forKey: nil)
viewController.navigationController?.pushViewController(destinationVC, animated: false)
