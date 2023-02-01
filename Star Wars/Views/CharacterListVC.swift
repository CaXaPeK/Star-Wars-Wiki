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
    
    func getImage(id: Int) -> UIImageView {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/characters/\(id).jpg") else { return UIImageView() }
        var imageView: UIImageView = UIImageView()
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    imageView.image = UIImage(data: data) ?? UIImage()
                    print(id)
                    print(imageView.image)
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
        
        return imageView
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

}
