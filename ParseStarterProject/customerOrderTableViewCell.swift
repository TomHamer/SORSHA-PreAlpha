//
//  customerOrderTableViewCell.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 2/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit



class customerOrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tagsText: UITextView!
    
    @IBOutlet weak var cafeLabel: UILabel!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    @IBOutlet weak var deliveryMethod: UILabel!

    @IBOutlet weak var blendTypeTag: UILabel!

    @IBOutlet weak var strengthTypeTag: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var milkTypeTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
