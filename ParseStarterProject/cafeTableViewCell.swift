//
//  cafeTableViewCell.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 8/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class cafeTableViewCell: UITableViewCell {

    @IBOutlet weak var cafeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
