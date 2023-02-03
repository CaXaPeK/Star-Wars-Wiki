//
//  CharacterVC.swift
//  Star Wars
//
//  Created by Admin on 01.02.2023.
//

import UIKit
import Alamofire

class CharacterVC: UIViewController {
    
    @IBOutlet var raceTGR: UITapGestureRecognizer!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var personHomeworld: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var personRace: UILabel!
    @IBOutlet weak var personDetails: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func racePressed(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "SpecieSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpecieSegue" {
            let destinationVC = segue.destination as? SpecieVC
            destinationVC?.title = specie.name ?? "Specie"
            destinationVC?.url = specie.url ?? ""
        }
    }
    
    var id: Int = 0
    var person: Person = defaultPerson
    var planet: Planet = defaultPlanet
    var specie: Specie = defaultSpecie

    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = avatar.bounds.height / 2
        
        self.personHomeworld.text = "Home planet: Loading..."
        self.personRace.text = "Race: Loading..."
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
                    self.loadRaceName()
                    self.activityIndicator.self.isHidden = true
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
    
    func loadRaceName() {
        var urlText = ""
        if person.species?.count == 0 {
            urlText = "https://swapi.dev/api/species/1/"
        }
        else {
            urlText = person.species?[0] ?? ""
        }
        guard let url = URL(string: urlText) else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Specie.self, from: data) else { return }
                    self.specie = decodedData
                    
                    self.personRace.text = "Race: \(self.specie.name ?? "Unknown")"
                    self.raceTGR.isEnabled = true
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
