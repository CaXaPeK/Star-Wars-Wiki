//
//  PlanetTableViewCell.swift
//  Star Wars
//
//  Created by Admin on 03.02.2023.
//

import UIKit
import Alamofire

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = avatar.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(id: Int) {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/planets/\(id).jpg") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.avatar.image = UIImage(data: data) ?? UIImage()
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
    
    func configure(with model: Planet, imageID: Int) {
        name.text = model.name
        loadImage(id: imageID)
    }
    
}
