//
//  VehicleVC.swift
//  Star Wars
//
//  Created by Admin on 03.02.2023.
//

import UIKit
import Alamofire

class VehicleVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var id = ""
    var vehicle: Vehicle = defaultVehicle

    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = avatar.bounds.height / 4
        getRequest()
        loadImage()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://swapi.dev/api/vehicles/\(id)/?format=json") else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let decodedData = try? JSONDecoder().decode(Vehicle.self, from: data) else { return }
                    self.vehicle = decodedData
                    
                    self.text.text = "Model: \(self.vehicle.model ?? "Unknown")\nManufacturer: \(self.vehicle.manufacturer ?? "Unknown")\nClass: \(self.vehicle.vehicle_class ?? "No")\nCost: \(self.vehicle.cost_in_credits ?? "Unknown") credits\nSpeed: \(self.vehicle.max_atmosphering_speed ?? "Unknown") km/h\nLength: \(self.vehicle.length ?? "Unknown")\nCargo capacity: \(self.vehicle.cargo_capacity ?? "Unknown")\nMinimum crew: \(self.vehicle.crew ?? "Unknown")\nPassengers: \(self.vehicle.passengers ?? "Unknown")"
                    self.scrollView.isHidden = false
                    self.activityIndicator.self.isHidden = true
                case .failure(let error):
                    print(error)
                    print(url)
                }
            }
    }
    
    func loadImage() {
        guard let url = URL(string: "https://starwars-visualguide.com/assets/img/vehicles/\(id).jpg") else { return }
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
