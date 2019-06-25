//
//  ScoreTableViewCell.swift
//  00457045_HW3
//
//  Created by User23 on 2019/6/25.
//  Copyright © 2019 Lin. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
