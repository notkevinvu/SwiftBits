//
//  TestHeaderView.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 4/2/21.
//


/*
 MARK: Adding section header
 
 There are multiple ways we can start out with, but we will start with the
 header view itself.
 
 1)
    Create the header view class, which should descend from the
    'UICollectionReusableView' class. Good to create a static identifier
    property to use as a reuseIdentifier.
 2)
    Register the supplementary view in the collection view closure initializer
    (via the collectionView.register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) method)
 3)
    After creating a section object, create a header size object in your
    collection view layout code/method via 'NSCollectionLayoutSize' and then
    make the actual header object (NSCollectionLayoutBoundarySupplementaryItem),
    passing in either a custom string variable for the 'elementKind' or by
    passing UICollectionView.elementKindSectionHeader for 'elementKind'
 3a)
    Optionally, we can set the header's pinToVisibleBounds property if we want
    a "sticky" header that will be visible whenever the header's section is
    visible
 4)
    We then add the header to the section by setting the section's
    boundarySupplementaryItems, which should be an array of boundary
    supplementary items (like our header)
 5)
    For a diffable data source, we must provide the data source with a
    supplementaryViewProvider closure to dequeue the header view.
    A separate method can work as long as you can access your configured data source.
    
    ex:
 private func configureHeaderView() {
     dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
         
         let header = collectionView.dequeueReusableSupplementaryView(
             ofKind: UICollectionView.elementKindSectionHeader,
             withReuseIdentifier: TestHeaderView.identifier,
             for: indexPath) as? TestHeaderView
         
         return header
     }
 }
 
 6)
    We should be done with the basic configuration of the header view.
    Footer views (and even side views) can be done in similar ways, just
    need to set the alignment in our collection view layout code.
 */

import UIKit

final class TestHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = "TestHeaderView"
    
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26)
        label.tintColor = .red
        label.textAlignment = .center
        label.text = "TEST HEADER VIEW"
        
        return label
    }()
    
    // MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureTitleLabelConstraints() {
        let labelTopAnchor = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        let labelBottomAnchor = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        labelBottomAnchor.priority = UILayoutPriority(999)
        
        let labelLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let labelTrailingAnchor = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        labelTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            labelTopAnchor,
            labelBottomAnchor,
            labelLeadingAnchor,
            labelTrailingAnchor
        ])
    }
    
    private func setupSubviews() {
        addSubviews()
        configureTitleLabelConstraints()
    }
    
    private func configureSelfView() {
        backgroundColor = .green
    }
    
    private func setup() {
        setupSubviews()
        configureSelfView()
    }
    
}
