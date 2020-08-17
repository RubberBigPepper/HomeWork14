//
//  TodoTableViewCell.swift
//  HomeWork14
//
//  Created by Albert on 14.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var whatLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
