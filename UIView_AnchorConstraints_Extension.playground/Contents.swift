import UIKit


extension UIView {
    /**
     Simple function call for setting UIView anchors/constraints.
     
     This function should be called in one of two ways (excluding padding):
     - 1):
     All four anchor parameters are passed to the function to be set and activated. Padding is passed a .zero version of `UIEdgeInsets` by default, but can be provided a custom inset for constant padding on anchors.
     - 2):
     Two anchor parameters are passed to the function along with a `CGSize`. This allows a custom size for the view as well as anchor points (e.g. top and leading anchor + a custom size)
     */
    func setAndActivateConstraints(top: NSLayoutYAxisAnchor?,
                                   bottom: NSLayoutYAxisAnchor?,
                                   leading: NSLayoutXAxisAnchor?,
                                   trailing: NSLayoutXAxisAnchor?,
                                   padding: UIEdgeInsets = .zero,
                                   size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
