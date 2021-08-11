//
//  TaskCell.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(task: Task) {
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
    }    
}
