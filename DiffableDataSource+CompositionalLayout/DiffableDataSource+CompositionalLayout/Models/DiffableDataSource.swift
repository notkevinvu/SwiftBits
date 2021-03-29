//
//  DiffableDataSource.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 3/27/21.
//

import UIKit

final class DiffableDataSource: NSObject {
    
    // MARK: - Snapshot intermediate
    // this is used as an intermediate to get the objects we want to add to
    // the collection view and the section we want to add it to
    struct ModelForSnapshot {
        var models: [TestModel]
        var section: Section
    }
    
    
    // MARK: - Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TestModel>
    var dataSource: DataSource!
    
    
    // MARK: - Init
    init(collectionView: UICollectionView) {
        super.init()
        self.dataSource = makeDataSource(forCollectionView: collectionView)
    }
    
}



// MARK: - Utility methods
extension DiffableDataSource {
    
    
    // MARK: - Make data source
    private func makeDataSource(forCollectionView collectionView: UICollectionView) -> DataSource {
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.identifier, for: indexPath) as? TestCollectionViewCell
            
            cell?.imageView.image = model.image
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
    
    // MARK: - Apply snapshot
    public func applySnapshot(forItems items: [ModelForSnapshot]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TestModel>()
        
        /*
         the following code allows us to adjust for scenarios where we pass in
         multiple intermediate model objects that are designated for the same
         section (i.e. if we somehow fetched/received two different arrays of
         TestModels that are meant for the same section)
         
         this code maps the sections we pass in via the intermediate models
         and adds them uniquely to the snapshot in the correct order (that is,
         the order specified by the enum Section), even if applySnapshot(forItems:)
         has them in the wrong order
         */
        let sections = items.map({ $0.section })
        var uniqueSections: [Section] = []
        
        for section in Section.allCases {
            if sections.contains(section) && !uniqueSections.contains(section) {
                uniqueSections.append(section)
            }
        }
        
        snapshot.appendSections(uniqueSections)
        
        for item in items {
            snapshot.appendItems(item.models, toSection: item.section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Remove item
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
             arrayTwo,
             arrayThree
//             arrayFour
    }
}

