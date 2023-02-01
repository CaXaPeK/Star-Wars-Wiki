//
//  CharacterListVC.swift
//  Star Wars
//
//  Created by Admin on 30.01.2023.
//

import UIKit
import Alamofire

class CharacterListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var list: PeopleList = defaultPeopleList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
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
        cell.configure(with: list.results?[indexPath.row] ?? defaultPerson)
        
        return cell
    }

}
