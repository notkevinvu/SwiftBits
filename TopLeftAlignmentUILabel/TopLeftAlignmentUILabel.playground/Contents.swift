import UIKit


class CustomView: UIView {
    
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        // numberOfLines = 0 -> dynamic # of lines
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    
    // MARK: Object lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupSubviews() {
        addSubview(containerView)
        
        containerView.addSubview(textLabel)
        
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            textLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            /*
             dynamically vertical resizing bottom anchor (i.e. top left alignment)
             the text label will always start at the top and left anchor
             
             we set the bottom anchor to be less than or equal to the container
             view's bottom anchor (-100 pts / 100 pts above it) which means it will
             only ever expand to the bottom anchor and no further below it
             
             but if the text label does not need it, the bottom anchor will simply
             shrink to fit the text
             */
             
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -100)
        ])
    }
    
    
}





