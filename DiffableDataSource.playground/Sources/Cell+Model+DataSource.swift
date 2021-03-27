import UIKit


// MARK: - Collection view cell
public final class TestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "testCollectionViewCell"
    
    public let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    public let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View methods
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviewLayers()
    }
    
    
    // MARK: - Utility methods
    private func setupLabel() {
        contentView.addSubview(label)
        
        let labelTopAnchor = label.topAnchor.constraint(equalTo: contentView.topAnchor)
        let labelBottomAnchor = label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        labelBottomAnchor.priority = UILayoutPriority(999)
        
        let labelLeadingAnchor = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let labelTrailingAnchor = label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        labelTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            labelTopAnchor,
            labelBottomAnchor,
            labelLeadingAnchor,
            labelLeadingAnchor
        ])
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        let imageTopAnchor = imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let imageBottomAnchor = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        imageBottomAnchor.priority = UILayoutPriority(999)
        
        let imageLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let imageTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        imageTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            imageTopAnchor,
            imageBottomAnchor,
            imageLeadingAnchor,
            imageTrailingAnchor
        ])
    }
    
    private func setupSubviews() {
        setupLabel()
        setupImageView()
    }
    
    private func configureSubviewLayers() {
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}








// MARK: - TestModel
public struct TestModel: Hashable {
    public var id: String = UUID().uuidString
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}









// MARK: - Diffable Data Source
public final class DiffableDataSource: NSObject {
    
    // MARK: - Snapshot intermediate
    // this is used as an intermediate to get the objects we want to add to
    // the collection view and the section we want to add it to
    public struct ModelForSnapshot {
        var models: [TestModel]
        var section: Section
    }
    
    // MARK: - Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TestModel>
    var dataSource: DataSource!
    
    // MARK: - Init
    public init(collectionView: UICollectionView) {
        super.init()
        self.dataSource = makeDataSource(forCollectionView: collectionView)
    }
    
}


// MARK: - Utility methods
extension DiffableDataSource {
    
    private func makeDataSource(forCollectionView collectionView: UICollectionView) -> DataSource {
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.identifier, for: indexPath) as? TestCollectionViewCell
            
            
            // need to call layoutIfNeeded here so that the cell calls its
            // layoutSubviews() method immediately, rather than at the next
            // update cycle (i.e. synchronously instead of async as with
            // setNeedsLayout())
            // previously, if we used setNeedsLayout(), the cell does not
            // properly call layoutSubviews() before we scroll to new cells
            cell?.layoutIfNeeded()
            
            return cell
        })
    }
    
    public func applySnapshot(forItems items: [ModelForSnapshot]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TestModel>()
        snapshot.appendSections(Section.allCases)
        
        for item in items {
            snapshot.appendItems(item.models, toSection: item.section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    public func remove(_ model: TestModel, animate: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([model])
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}

// MARK: - Sections
extension DiffableDataSource {
    enum Section: CaseIterable {
        case arrayOne,
             arrayTwo
    }
}
