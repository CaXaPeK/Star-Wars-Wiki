//
//  CategorySelectVC.swift
//  Star Wars
//
//  Created by Admin on 29.01.2023.
//

import UIKit

class CategorySelectVC: UIViewController {

    @IBAction func imageClicked(_ sender: Any) {}
    
    @IBOutlet weak var CharacterButton: UIImageView!
    @IBOutlet weak var FilmsButton: UIImageView!
    @IBOutlet weak var PlanetsButton: UIImageView!
    @IBOutlet weak var SpeciesButton: UIImageView!
    @IBOutlet weak var StarshipsButton: UIImageView!
    @IBOutlet weak var VehiclesButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a Category"
        
        CharacterButton.layer.cornerRadius = CharacterButton.bounds.height / 8
        FilmsButton.layer.cornerRadius = FilmsButton.bounds.height / 8
        PlanetsButton.layer.cornerRadius = PlanetsButton.bounds.height / 8
        SpeciesButton.layer.cornerRadius = SpeciesButton.bounds.height / 8
        StarshipsButton.layer.cornerRadius = StarshipsButton.bounds.height / 8
        VehiclesButton.layer.cornerRadius = VehiclesButton.bounds.height / 8
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
