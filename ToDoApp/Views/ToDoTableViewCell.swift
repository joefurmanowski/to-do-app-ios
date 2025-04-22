//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoTask: UILabel!
    @IBOutlet weak var addedBy: UILabel!
    @IBOutlet weak var completedBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
