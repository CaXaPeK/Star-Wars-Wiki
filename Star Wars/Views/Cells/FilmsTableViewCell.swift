//
//  FilmsTableViewCell.swift
//  Star Wars
//
//  Created by Admin on 01.02.2023.
//

import UIKit
import Alamofire

class FilmsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmReleaseYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = avatar.bounds.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(id: String) {
        avatar.image = UIImage()
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/films/\(id).jpg") else { return }
        
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
    
    func configure(with model: Film, imageID: String) {
        filmName.text = model.title
        filmReleaseYear.text = "Released: \(model.release_date ?? "Unknown")"
        loadImage(id: imageID)
    }
    
}
