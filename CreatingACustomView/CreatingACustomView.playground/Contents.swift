import UIKit


// MARK: Setting up a custom view

 /*
 1) setup deckdetailview by adding init() and required init?(coder:) methods
 2) go to deckdetailVC, add a "contentView" var which is of type DeckDetailView!
 3) in the private setup() method, add "let view = DeckDetailView()" and "viewController.contentView = view"
 4) set the view of the VC to the content view in the loadView() lifecycle method
 
 
 OPTIONAL FOR COLLECTION VIEW:
 
 5) put collection view methods in an extension of the deck detail VC, which should conform to the UICollectionViewFlowLayoutDelegate and UICollectionViewDataSource protocols
 6) remember to set the delegate and data source of the contentView.collectionView to self in the deck detail VC (i.e. the delegate/data source of the DeckDetailView's collectionView should be DeckDetailViewController)
 */



// Following the above - this use case is for setting up a custom view that uses
// a collection view and a custom collection view cell


// MARK: DeckDetailDelegate
protocol DeckDetailViewDelegate: class {
    // class conformance is required for weak variables
    
//    func deckDetailViewSelectReviewDeck(request: DeckDetail.ShowReviewDeck.Request)
}

class DeckDetailView: UIView {
    
    // MARK: Properties
    // these are OPTIONAL - typically used for any button methods
    typealias Delegate = DeckDetailViewDelegate
    weak var delegate: Delegate?
    
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 360, height: 140)
        // bottom inset allows users to scroll to see last card if there are more
        // than 4 cards
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DeckDetailCollectionViewCell.self, forCellWithReuseIdentifier: DeckDetailCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    
    let reviewDeckButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Review Deck", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        
//        let reviewDeckButtonColor = UIColor(hex: "3399fe")
//        button.backgroundColor = reviewDeckButtonColor
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleTapReviewDeckButton), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: Delegate Methods
    
    @objc func handleTapReviewDeckButton() {
//        let request = DeckDetail.ShowReviewDeck.Request()
//        delegate?.deckDetailViewSelectReviewDeck(request: request)
    }
    
    
    // MARK: Object lifecycle

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupSubViews() {
        
        // Adding subviews
        addSubview(collectionView)
        addSubview(reviewDeckButton)
        
        NSLayoutConstraint.activate([
            // collection view
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            
            // study deck button
            reviewDeckButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            reviewDeckButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
            reviewDeckButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            reviewDeckButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
    }
    
}











// MARK: - DeckDetailCollectionViewCell

class DeckDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCellView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    
    static let identifier = "DeckDetailCollectionCell"
    
    // callback functions to tell VC that a button was tapped
    var didTapEditButton: (() -> ())?
    var didTapDeleteButton: (() -> ())?
    
    
    struct CardCellModel {
        let frontSide: String
        let backSide: String
    }
    
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    let cardFrontSideLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        
        return label
    }()
    
    
    let cardFrontAndBackSeparator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
       return view
    }()
    
    
    let cardBackSideLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    
    lazy var editButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        // UIColor(hex:) is a custom extension, google if needed
//        button.backgroundColor = UIColor(hex: "a4dced")
        button.layer.cornerRadius = self.layer.cornerRadius
        button.layer.maskedCorners = [.layerMaxXMinYCorner]
        button.layer.borderWidth = 0.5
        
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(handleTapEditButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    // used to animate the button in
    var editButtonWidthAnchor: NSLayoutConstraint?
    
    
    // same code as in decks view cell, create extension to place all this code in?
    lazy var deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(hex: "eb8888")
        button.layer.cornerRadius = self.layer.cornerRadius
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.layer.borderWidth = 0.5
        
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(handleTapDeleteButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    var deleteButtonWidthAnchor: NSLayoutConstraint?
    
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(toggleEditViews))
        
        return tap
    }()
    
    
    // MARK: Setup
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(cardFrontAndBackSeparator)
        containerView.addSubview(cardFrontSideLabel)
        containerView.addSubview(cardBackSideLabel)
        containerView.addSubview(deleteButton)
        containerView.addSubview(editButton)
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        editButtonWidthAnchor = editButton.widthAnchor.constraint(equalToConstant: 0)
        // activate here so we don't need to unwrap in the .activate() method
        editButtonWidthAnchor?.isActive = true
        deleteButtonWidthAnchor = deleteButton.widthAnchor.constraint(equalToConstant: 0)
        deleteButtonWidthAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            cardFrontAndBackSeparator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            cardFrontAndBackSeparator.bottomAnchor.constraint(equalTo: cardFrontAndBackSeparator.topAnchor, constant: 0.5),
            cardFrontAndBackSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            cardFrontAndBackSeparator.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            
            cardFrontSideLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
            cardFrontSideLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
            cardFrontSideLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            cardFrontSideLabel.bottomAnchor.constraint(equalTo: cardFrontAndBackSeparator.topAnchor, constant: -5),
            
            
            cardBackSideLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
            cardBackSideLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
            cardBackSideLabel.topAnchor.constraint(equalTo: cardFrontAndBackSeparator.bottomAnchor, constant: 5),
            cardBackSideLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            
            editButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            editButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            editButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            deleteButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            deleteButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    
    private func configureCellView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowRadius = 8
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.25
        
    }
    
    
    // MARK: Display configuration
    
    public func configureWithModel(_ model: CardCellModel) {
        cardFrontSideLabel.text = model.frontSide
        cardBackSideLabel.text = model.backSide
    }
    
    @objc func toggleEditViews() {
        if editButtonWidthAnchor?.constant == 0 {
            
            editButtonWidthAnchor?.constant = 80
            deleteButtonWidthAnchor?.constant = 80
        } else {
            editButtonWidthAnchor?.constant = 0
            deleteButtonWidthAnchor?.constant = 0
        }
        
        UIView.animate(withDuration: 0.2) {
            self.contentView.layoutIfNeeded()
        }
    }
    
    
    // MARK: - Methods
    
    /*
     when the buttons are tapped, this method is called
     this method then calls the didTapEditButton callback variable, which is
     defined in the view controller's collection view delegate methods
     
     when the didTap...Button variable methods get called, it calls whatever code
     we set in the collection view (in the view controller)
     */
    @objc func handleTapEditButton(sender: UIButton) {
        didTapEditButton?()
    }
    
    @objc func handleTapDeleteButton(sender: UIButton) {
        didTapDeleteButton?()
    }
    
    
}
