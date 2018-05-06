//
//  TaskCell.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 4. 29..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
