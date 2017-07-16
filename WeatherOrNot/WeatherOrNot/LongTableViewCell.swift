//
//  LongTableViewCell.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 6/25/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class LongTableViewCell: UITableViewCell {
    
    let cellType: mainTableCellType = .Long
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        let reuseIdentifier = "longcell"
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
