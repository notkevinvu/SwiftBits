//
//  TestCollectionViewCell.swift
//  DiffableDataSource+CompositionalLayout
//
//  Created by Kevin Vu on 3/27/21.
//


import UIKit

final class TestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "testCollectionViewCell"
    
    let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviewLayers()
    }
    
    
    // MARK: - Utility methods
    private func setupSubviews() {
        contentView.addSubview(imageView)
        
        let imageTopAnchor = imageView.topAnchor.constraint(equalTo: topAnchor)
        let imageBottomAnchor = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        imageBottomAnchor.priority = UILayoutPriority(999)
        
        let imageLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let imageTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        imageTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            imageTopAnchor,
            imageBottomAnchor,
            imageLeadingAnchor,
            imageTrailingAnchor
        ])
    }
    
    private func configureSubviewLayers() {
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}

