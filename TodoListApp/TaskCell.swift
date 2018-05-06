//
//  TaskCell.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 4. 29..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit

protocol TaskComplete {
    
    func taskComplete(idx index:Int)
}

class TaskCell: UITableViewCell {
    
    var delegate:TaskComplete?
    
    public var index = -1

    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBAction func taskCompleteAction(_ sender: Any) {
        delegate?.taskComplete(idx:self.index);
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
