//
//  TestView.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 3/27/21.
//

import UIKit

// MARK: - Custom view
class TestView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let cView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = .systemBackground
        
        cView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: TestCollectionViewCell.identifier)
        cView.register(TestHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TestHeaderView.identifier)
        
        return cView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Setup
extension TestView {
    

    // MARK: - Collection view layout
    private func createLayout() -> UICollectionViewLayout {
        /*
         Compositional layouts are usually comprised of items, groups, and
         sections. Items fit into groups and groups fit into sections.
         
         The layout is built using sections while the sections themselves are
         comprised of group instances.
         */
        
        // width fills its container's width, and likewise for the height
        // groups are usually the containers for items
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
        
        /*
         for groups:
         width fills its container's width (the section's width in this case)
         height is about 50% of the container's width (i.e. the section once
         again); this results in square frame items
         
         alternatively we could use either .absolute(x) where x is an integer
         representing the number of points you want the dimension to be (wide
         or tall)
         
         we could also use .estimated(x) to let the system decide the optimal
         height for an item based on its contents
         */
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        
        // Note the .horizontal initializer. This means the group will position
        // items horizontally until it has filled up its width, and then it
        // starts positioning items on the next "line" until that contains
        // as many items as can be fit in the group's width and so on
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        // if we want horizontal scrolling, we can set the orthogonalScrollingBehavior
        // property of each section to one of its non-none values (default is .none)
//        section.orthogonalScrollingBehavior = .continuous
        
        // creation of a header boundary supplementary view for sections
        // we can use this as a basis for footer views; just need to change the
        // alignment
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        
        // self explanatory, we can have spacing in between sections
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // MARK: - Setup collection view
    private func setupCollectionView() {
        addSubview(collectionView)
        
        let collectionTopAnchor = collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        let collectionBottomAnchor = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        collectionBottomAnchor.priority = UILayoutPriority(999)
        
        let collectionLeadingAnchor = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let collectionTrailingAnchor = collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        collectionTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            collectionTopAnchor,
            collectionBottomAnchor,
            collectionLeadingAnchor,
            collectionTrailingAnchor
        ])
    }
}

