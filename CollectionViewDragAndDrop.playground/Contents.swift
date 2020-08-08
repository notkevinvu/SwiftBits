import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TestCollectionViewCellIdentifier"
    
    struct CellModel {
        let exampleLabelText: String
        let anotherLabelText: String
    }
    
    // ideally use lazy vars to setup UI elements
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureCellView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        
        configureCellView()
        setupSubviews()
    }
    
    func configureCellView() {
        // stuff like:
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowRadius = 8
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.25
    }
    
    func setupSubviews() {
        // add subviews to content view
        // contentView.addSubview(exampleLabel)
        
        // then set and activate constraints
        NSLayoutConstraint.activate([
            // exampleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            // example...
        ])
    }
}




class TestViewController: UIViewController {
    
//    var contentView: ExampleView!
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 360, height: 110)
        // bottom edge inset added to allow users to scroll up more to see last deck
        // if there are more than 4 decks
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: TestCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // give collection view a bit more space at top from the title/nav bar
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.alwaysBounceVertical = true
        collectionView.dragInteractionEnabled = true
        
        collectionView.collectionViewLayout = layout
        
        return collectionView
    }()
    
    override func loadView() {
        super.loadView()
        // here is where we set the view as our custom view class where var contentView = ExampleView!
        
        // view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var cellModels: [TestCollectionViewCell.CellModel] = []
    
    
    func configureCollectionView() {
        // using clean swift, we access the collection view through the custom content view
        // as we should initialize the collection view inside the custom content view
        
//        contentView.collectionView.delegate = self
//        contentView.collectionView.dataSource = self
        
        // MARK: REQUIRED FOR DRAG/DROP
//        contentView.collectionView.dragDelegate = self
//        contentView.collectionView.dropDelegate = self
    }
    
}

extension TestViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let item = cellModels[indexPath.row]
        
        let itemProvider = NSItemProvider(object: item.exampleLabelText as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        
        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
    
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        
        guard
            let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath
            else {
                return
        }
        
        collectionView.performBatchUpdates({
            let cellModelToMove = cellModels.remove(at: sourceIndexPath.item)
            cellModels.insert(cellModelToMove, at: destinationIndexPath.item)
            
            collectionView.deleteItems(at: [sourceIndexPath])
            collectionView.insertItems(at: [destinationIndexPath])
        }, completion: nil)
        
        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        
        // here is where we call an interactor method to reorder the items in our
        // memory store -  REFER TO Spaced Repetition, DecksInteractor.swift
        // and DecksWorker.swift for an example reorder method
        
    }
}
