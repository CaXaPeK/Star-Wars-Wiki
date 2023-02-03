//
//  PlanetVC.swift
//  Star Wars
//
//  Created by Admin on 03.02.2023.
//

import UIKit
import Alamofire

class PlanetVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var id = ""
    var planet: Planet = defaultPlanet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = avatar.bounds.height / 2
        getRequest()
        loadImage()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://swapi.dev/api/planets/\(id)/?format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Planet.self, from: data) else { return }
                    self.planet = decodedData
                    
                    self.text.text = "Population: \(self.planet.population ?? "Unknown")\nRotation period: \(self.planet.rotation_period ?? "Unknown") days\nOrbital period: \(self.planet.orbital_period ?? "Unknown") days\nDiameter: \(self.planet.diameter ?? "Unknown") km\nGravity: \(self.planet.gravity?.capitalized ?? "Unknown")\nTerrain: \(self.planet.terrain?.capitalized ?? "Unknown")\nSurface water: \(self.planet.surface_water ?? "Unknown")%\nClimate: \(self.planet.climate?.capitalized ?? "Unknown")"
                    self.scrollView.isHidden = false
                    self.activityIndicator.self.isHidden = true
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
    
    func loadImage() {
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

}
