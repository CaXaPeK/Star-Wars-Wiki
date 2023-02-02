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
    
    private var list: PeopleList = defaultPeopleList
    private var pageID = 1
    private var pageCount = 0
    private var selectedItemTitle = ""
    private var selectedItemId = 0
    
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
        list = defaultPeopleList
        tableView.reloadData()
        PageLabel.self.isHidden = true
        NextButton.self.isHidden = true
        PrevButton.self.isHidden = true
        ActivityIndicator.self.isHidden = false
        getRequest(pageID: pageID)
    }
    
    @IBAction func PrevPageButtonPress(_ sender: UIButton) {
        pageID -= 1
        list = defaultPeopleList
        tableView.reloadData()
        PageLabel.self.isHidden = true
        NextButton.self.isHidden = true
        PrevButton.self.isHidden = true
        ActivityIndicator.self.isHidden = false
        getRequest(pageID: pageID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        tableView.layer.cornerRadius = tableView.bounds.height / 32
        
        tableView.register(UINib(nibName: "PeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopleTableViewCell")
        
        getRequest(pageID: 1)
    }
    
    func getRequest(pageID: Int) {
        guard let url = URL(string: "https://swapi.dev/api/people/?page=\(pageID)&format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(PeopleList.self, from: data) else { return }
                    self.list = decodedData
                    self.tableView.reloadData()
                    
                    self.ActivityIndicator.self.isHidden = true
                    self.PageLabel.self.isHidden = false
                    self.pageCount = Int(ceil(Double(self.list.count ?? 0) / 10.0))
                    self.PageLabel.text = "Page \(pageID) of \(self.pageCount)"
                    self.unhideButtons()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: list.results?[indexPath.row] ?? defaultPerson, imageID: (indexPath.row + 10 * (self.pageID - 1)) + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemTitle = list.results?[indexPath.row].name ?? "Character"
        selectedItemId = (indexPath.row + 10 * (pageID - 1)) + 1
        performSegue(withIdentifier: "CharacterSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterSegue" {
            let destinationVC = segue.destination as? CharacterVC
            destinationVC?.title = selectedItemTitle
            destinationVC?.id = selectedItemId
        }
    }

}
