//
//  SenderAccountCelllTableViewCell.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class SenderAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
