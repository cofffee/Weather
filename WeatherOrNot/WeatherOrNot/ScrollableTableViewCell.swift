//
//  ScrollableTableViewCell.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 6/25/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class ScrollableTableViewCell: UITableViewCell {
    
    var collectionView: UICollectionView? = nil
    let cellType: mainTableCellType = .HorizontalScrollable
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        let reuseIdentifier = "scrollablecell"
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() 

        let collectionFrame: CGRect = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.gray
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.itemSize = CGSize(width: 88, height: 120)
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .horizontal
        
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        contentView.addSubview(collectionView!)
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.1)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView?.frame = contentView.bounds
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    func setCollectionViewDataSourceDelegate (dataSource: UICollectionViewDataSource, dataDelegate: UICollectionViewDelegate, forRow row: Int) {
        
        collectionView?.delegate = dataDelegate
        collectionView?.dataSource = dataSource
        collectionView?.tag = row
        collectionView?.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
