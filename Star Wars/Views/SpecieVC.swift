//
//  SpecieVC.swift
//  Star Wars
//
//  Created by Admin on 04.02.2023.
//

import UIKit
import Alamofire

class SpecieVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var text: UILabel!
    
    var url = ""
    var specie = defaultSpecie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getRequest()
    }
    
    func getRequest() {
        guard let url = URL(string: self.url) else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Specie.self, from: data) else { return }
                    self.specie = decodedData
                    
                    self.text.text = "Classification: \(self.specie.classification?.capitalized ?? "Unknown")\nLanguage: \(self.specie.language ?? "Unknown")\nAverage lifespan: \(self.specie.average_lifespan ?? "Unknown") years\nAverage height: \(self.specie.average_height ?? "Unknown") cm\nEye color(s): \(self.specie.eye_colors?.capitalized ?? "Unknown")\nSkin color(s): \(self.specie.skin_colors?.capitalized ?? "Unknown")\nHair color(s): \(self.specie.hair_colors?.capitalized ?? "Unknown")"
                    self.scrollView.isHidden = false
                    self.activityIndicator.self.isHidden = true
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
