//
//  ViewController.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 3/27/21.
//

import UIKit

// MARK: - TODO:
/*
 If we ever want to utilize multiple sections that are user-editable (i.e.
 the user can add or remove sections which serve as groupings), might be a good
 idea to have a container array that holds the other arrays. Then, we can have
 our applySnapshot() method add all of the sub-arrays to the snapshot.
 */

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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTestItem))
    }
    
    private func fetchModels() {
        // in a real app, fetchModels() should call a method from the data store
        // to fetch data to feed the collection view. Once we get the data,
        // we pass in the below code
        applySnapshot()
    }
    
    // convenience method for applying snapshot
    private func applySnapshot() {
        dataSource.applySnapshot(forItems: [
            DiffableDataSource.ModelForSnapshot(models: modelArray, section: .arrayOne),
            DiffableDataSource.ModelForSnapshot(models: modelArrayTwo, section: .arrayTwo),
            DiffableDataSource.ModelForSnapshot(models: modelArrayThree, section: .arrayThree)
        ])
    }
    
    @objc private func addTestItem() {
        let itemToAdd = TestModel(image: UIImage(systemName: "heart.fill")!)
        modelArray.append(itemToAdd)
        // when adding an item, all we need to do is add it to the corresponding
        // array and then call our convenience method for applying a snapshot
        // (this convenience method should apply a snapshot for all arrays we
        // need)
        
        applySnapshot()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Data source code
    // the following code is sample code if we were to simply implement it
    // within the view controller rather than as its own class
    
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


