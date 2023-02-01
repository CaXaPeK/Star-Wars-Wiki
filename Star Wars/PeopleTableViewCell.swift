//
//  PeopleTableViewCell.swift
//  Star Wars
//
//  Created by Admin on 01.02.2023.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var PersonNameLabel: UILabel!
    @IBOutlet weak var PersonBirthYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Person) {
        PersonNameLabel.text = model.name
        PersonBirthYearLabel.text = "Born: \(model.birth_year ?? "unknown")"
    }
}
