//
//  mapCell.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import UIKit

class mapCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addreddLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    static let identifier = "mapCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "mapCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
