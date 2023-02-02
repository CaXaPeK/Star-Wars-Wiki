//
//  PeopleTableViewCell.swift
//  Star Wars
//
//  Created by Admin on 01.02.2023.
//

import UIKit
import Alamofire

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var PersonNameLabel: UILabel!
    @IBOutlet weak var PersonBirthYearLabel: UILabel!
    @IBOutlet weak var CellAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CellAvatar.layer.cornerRadius = CellAvatar.bounds.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(id: Int) {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/characters/\(id).jpg") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.CellAvatar.image = UIImage(data: data) ?? UIImage()
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
    
    func configure(with model: Person, imageID: Int) {
        PersonNameLabel.text = model.name
        PersonBirthYearLabel.text = "Born: \(model.birth_year ?? "Unknown")"
        loadImage(id: imageID)
    }
}
