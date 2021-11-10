//
//  UserCell.swift
//  RandomUser
//
//  Created by Ammar Khalil on 01/11/2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
