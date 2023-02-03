//
//  FilmVC.swift
//  Star Wars
//
//  Created by Admin on 03.02.2023.
//

import UIKit
import Alamofire

class FilmVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filmDescription: UILabel!
    @IBOutlet weak var filmData: UILabel!
    @IBOutlet weak var filmAvatar: UIImageView!
    
    var id = ""
    var film: Film = defaultFilm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequest()
        loadImage()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://swapi.dev/api/films/\(id)/?format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Film.self, from: data) else { return }
                    self.film = decodedData
                    
                    self.filmData.text = "Released: \(self.film.release_date ?? "Unknown")\nDirected by \(self.film.director ?? "Unknown")\nProduced by \(self.film.producer ?? "Unknown")"
                    self.filmDescription.text = "Opening crawl:\n\n\(self.film.opening_crawl ?? "No description")"
                    self.scrollView.isHidden = false
                    self.activityIndicator.self.isHidden = true
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
    
    func loadImage() {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/films/\(id).jpg") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.filmAvatar.image = UIImage(data: data) ?? UIImage()
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
}
