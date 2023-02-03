//
//  CharacterListVC.swift
//  Star Wars
//
//  Created by Admin on 30.01.2023.
//

import UIKit
import Alamofire

class CharacterListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var PrevButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var peopleList: PeopleList = defaultPeopleList
    private var filmList: FilmList = defaultFilmList
    private var planetList: PlanetList = defaultPlanetList
    private var vehicleList: VehicleList = defaultVehicleList
    
    private var pageID = 1
    private var pageCount = 0
    private var selectedItemTitle = ""
    private var selectedItemId = 0
    var category = ""
    
    func unhideButtons() {
        if pageID == pageCount {
            NextButton.self.isHidden = true
        }
        else {
            NextButton.self.isHidden = false
        }
        
        if pageID == 1 {
            PrevButton.self.isHidden = true
        }
        else {
            PrevButton.self.isHidden = false
        }
    }
    
    @IBAction func NextPageButtonPress(_ sender: UIButton) {
        pageID += 1
        peopleList = defaultPeopleList
        filmList = defaultFilmList
        planetList = defaultPlanetList
        vehicleList = defaultVehicleList
        tableView.reloadData()
        PageLabel.self.isHidden = true
        NextButton.self.isHidden = true
        PrevButton.self.isHidden = true
        ActivityIndicator.self.isHidden = false
        getRequest(pageID: pageID)
    }
    
    @IBAction func PrevPageButtonPress(_ sender: UIButton) {
        pageID -= 1
        peopleList = defaultPeopleList
        filmList = defaultFilmList
        planetList = defaultPlanetList
        vehicleList = defaultVehicleList
        tableView.reloadData()
        PageLabel.self.isHidden = true
        NextButton.self.isHidden = true
        PrevButton.self.isHidden = true
        ActivityIndicator.self.isHidden = false
        getRequest(pageID: pageID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch category {
            case "people":
                title = "Characters"
                tableView.register(UINib(nibName: "PeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopleTableViewCell")
            case "films":
                title = "Films"
                tableView.register(UINib(nibName: "FilmsTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmsTableViewCell")
            case "planets":
                title = "Planets"
                tableView.register(UINib(nibName: "PlanetsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanetsTableViewCell")
            case "vehicles":
                title = "Vehicles"
                tableView.register(UINib(nibName: "VehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "VehiclesTableViewCell")
            default:
                title = "List"
            tableView.register(UINib(nibName: "PeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopleTableViewCell")
        }
        tableView.layer.cornerRadius = tableView.bounds.height / 32
        
        getRequest(pageID: 1)
    }
    
    func getRequest(pageID: Int) {
        guard let url = URL(string: "https://swapi.dev/api/\(category)/?page=\(pageID)&format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    var itemCount: Int
                    switch self.category {
                        case "people":
                            guard let decodedData = try? JSONDecoder().decode(PeopleList.self, from: data) else { return }
                            self.peopleList = decodedData
                            itemCount = self.peopleList.count ?? 0
                        case "films":
                            guard let decodedData = try? JSONDecoder().decode(FilmList.self, from: data) else { return }
                            self.filmList = decodedData
                            itemCount = self.filmList.count ?? 0
                        case "planets":
                            guard let decodedData = try? JSONDecoder().decode(PlanetList.self, from: data) else { return }
                            self.planetList = decodedData
                            itemCount = self.planetList.count ?? 0
                        case "vehicles":
                            guard let decodedData = try? JSONDecoder().decode(VehicleList.self, from: data) else { return }
                            self.vehicleList = decodedData
                            itemCount = self.vehicleList.count ?? 0
                        default:
                            return
                    }
                    self.tableView.reloadData()
                    
                    self.ActivityIndicator.self.isHidden = true
                    self.PageLabel.self.isHidden = false
                    self.pageCount = Int(ceil(Double(itemCount) / 10.0))
                    self.PageLabel.text = "Page \(pageID) of \(self.pageCount)"
                    self.unhideButtons()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.category {
            case "people":
                return peopleList.results?.count ?? 0
            case "films":
                return filmList.results?.count ?? 0
            case "planets":
                return planetList.results?.count ?? 0
            case "vehicles":
                return vehicleList.results?.count ?? 0
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.category {
            case "people":
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as? PeopleTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: peopleList.results?[indexPath.row] ?? defaultPerson, imageID: (indexPath.row + 10 * (self.pageID - 1)) + 1)
                return cell
            case "films":
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsTableViewCell", for: indexPath) as? FilmsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: filmList.results?[indexPath.row] ?? defaultFilm, imageID: (indexPath.row + 10 * (self.pageID - 1)) + 1)
                return cell
            case "planets":
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetsTableViewCell", for: indexPath) as? PlanetsTableViewCell else {
//                    return UITableViewCell()
//                }
//                cell.configure(with: planetList.results?[indexPath.row] ?? defaultPlanet, imageID: (indexPath.row + 10 * (self.pageID - 1)) + 1)
//                return cell
                return UITableViewCell()
            case "vehicles":
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehiclesTableViewCell", for: indexPath) as? VehiclesTableViewCell else {
//                    return UITableViewCell()
//                }
//                cell.configure(with: vehicleList.results?[indexPath.row] ?? defaultVehicle, imageID: (indexPath.row + 10 * (self.pageID - 1)) + 1)
//                return cell
                return UITableViewCell()
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.category {
            case "people":
                selectedItemTitle = peopleList.results?[indexPath.row].name ?? "Character"
                selectedItemId = (indexPath.row + 10 * (pageID - 1)) + 1
                performSegue(withIdentifier: "CharacterSegue", sender: self)
            case "films":
                selectedItemTitle = filmList.results?[indexPath.row].title ?? "Film"
                selectedItemId = (indexPath.row + 10 * (pageID - 1)) + 1
                performSegue(withIdentifier: "FilmSegue", sender: self)
            case "planets":
                selectedItemTitle = planetList.results?[indexPath.row].name ?? "Planet"
                selectedItemId = (indexPath.row + 10 * (pageID - 1)) + 1
                performSegue(withIdentifier: "PlanetSegue", sender: self)
            case "vehicles":
                selectedItemTitle = vehicleList.results?[indexPath.row].name ?? "Vehicle"
                selectedItemId = (indexPath.row + 10 * (pageID - 1)) + 1
                performSegue(withIdentifier: "VehicleSegue", sender: self)
            default:
                return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "CharacterSegue":
                let destinationVC = segue.destination as? CharacterVC
                destinationVC?.title = selectedItemTitle
                destinationVC?.id = selectedItemId
            case "FilmSegue":
                let destinationVC = segue.destination as? FilmVC
                destinationVC?.title = selectedItemTitle
                destinationVC?.id = selectedItemId
            case "PlanetSegue":
//                let destinationVC = segue.destination as? PlanetVC
//                destinationVC?.title = selectedItemTitle
//                destinationVC?.id = selectedItemId
                return
            case "VehicleSegue":
//                let destinationVC = segue.destination as? VehicleVC
//                destinationVC?.title = selectedItemTitle
//                destinationVC?.id = selectedItemId
                return
            default:
                return
        }
    }

}
