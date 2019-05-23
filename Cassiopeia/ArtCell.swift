//
//  ArtCell.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit

class ArtCell: UITableViewCell {
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artTitleLabel: UILabel!
    @IBOutlet weak var artImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
