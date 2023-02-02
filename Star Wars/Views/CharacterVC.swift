//
//  CharacterVC.swift
//  Star Wars
//
//  Created by Admin on 01.02.2023.
//

import UIKit
import Alamofire

class CharacterVC: UIViewController {
    
    @IBOutlet weak var personHomeworld: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var personRace: UILabel!
    @IBOutlet weak var personDetails: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var id: Int = 0
    var person: Person = defaultPerson
    var planet: Planet = defaultPlanet

    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = avatar.bounds.height / 2
        
        self.personHomeworld.text = "Home planet: Loading..."
        getRequest()
        loadImage()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://swapi.dev/api/people/\(id)/?format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Person.self, from: data) else { return }
                    self.person = decodedData
                    
                    self.personName.text = self.person.name
                    self.personDetails.text = "Born: \(self.person.birth_year ?? "Unknown")\nWeight: \(self.person.mass ?? "Unknown") kg\nGender: \(self.person.gender?.capitalized ?? "Unknown")\nHair color: \(self.person.hair_color?.capitalized ?? "Unknown")\nSkin color: \(self.person.skin_color?.capitalized ?? "Unknown")"
                    self.scrollView.isHidden = false
                    self.loadPlanetName()
//                    self.ActivityIndicator.self.isHidden = true
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadPlanetName() {
        guard let url = URL(string: person.homeworld ?? "") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Planet.self, from: data) else { return }
                    self.planet = decodedData
                    
                    self.personHomeworld.text = "Home planet: \(self.planet.name ?? "Unknown")"
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadImage() {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/characters/\(id).jpg") else { return }
        
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
