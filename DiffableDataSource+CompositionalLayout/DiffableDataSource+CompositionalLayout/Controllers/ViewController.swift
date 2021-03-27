//
//  ViewController.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 3/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
//    typealias DataSource = UICollectionViewDiffableDataSource<Section, TestModel>
//    lazy var dataSource: DataSource = makeDataSource()
    
    var contentView: TestView!
    
    lazy var dataSource = DiffableDataSource(collectionView: contentView.collectionView)
    
    var colorSet: [UIColor] = [.red, .orange, .yellow, .green, .blue, .systemIndigo, .purple]
    
    var modelArray: [TestModel] = [
        TestModel(image: UIImage(named: "momo1")!),
        TestModel(image: UIImage(named: "momo2")!),
        TestModel(image: UIImage(named: "momo3")!),
        TestModel(image: UIImage(named: "momo4")!),
        TestModel(image: UIImage(named: "momo5")!)
    ]
    
    var modelArrayTwo: [TestModel] = [
        TestModel(image: UIImage(named: "momo6")!),
        TestModel(image: UIImage(named: "momo7")!),
        TestModel(image: UIImage(named: "momo8")!),
        TestModel(image: UIImage(named: "momo9")!),
        TestModel(image: UIImage(named: "momo10")!)
    ]
    
    var modelArrayThree: [TestModel] = [
        TestModel(image: UIImage(named: "momo11")!),
        TestModel(image: UIImage(named: "momo12")!),
        TestModel(image: UIImage(named: "momo13")!),
        TestModel(image: UIImage(named: "momo14")!),
        TestModel(image: UIImage(named: "momo15")!)
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        fetchModels()
//        applySnapshot()
    }
    
    // MARK: - Setup
    private func setup() {
        let view = TestView()
        contentView = view
    }
    
    private func configureNavBar() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Test View"
    }
    
    private func fetchModels() {
        dataSource.applySnapshot(forItems: [
            DiffableDataSource.ModelForSnapshot(models: modelArray, section: .arrayOne),
            DiffableDataSource.ModelForSnapshot(models: modelArrayTwo, section: .arrayTwo),
            DiffableDataSource.ModelForSnapshot(models: modelArrayThree, section: .arrayTwo)
        ])
    }
    
//    private func makeDataSource() -> DataSource {
//        return DataSource(collectionView: contentView.collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.identifier, for: indexPath) as? TestCollectionViewCell
//
//            cell?.imageView.image = model.image
//            // need to call layoutIfNeeded here so that the cell calls its
//            // layoutSubviews() method immediately, rather than at the next
//            // update cycle (i.e. synchronously instead of async as with
//            // setNeedsLayout())
//            // previously, if we used setNeedsLayout(), the cell does not
//            // properly call layoutSubviews() before we scroll to new cells
//            cell?.layoutIfNeeded()
//
//            return cell
//        })
//    }
//
//    private func applySnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, TestModel>()
//        snapshot.appendSections([.arrayOne, .arrayTwo])
//        snapshot.appendItems(modelArray, toSection: .arrayOne)
//        snapshot.appendItems(modelArrayTwo, toSection: .arrayTwo)
//        dataSource.apply(snapshot)
//    }
}

// MARK: - Diff data source sections
//extension ViewController {
//    enum Section {
//        case arrayOne,
//             arrayTwo
//    }
//}


