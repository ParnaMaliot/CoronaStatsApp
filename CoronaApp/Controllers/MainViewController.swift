//
//  ViewController.swift
//  CoronaApp
//
//  Created by Igor Parnadjiev on 10/29/20.
//

import UIKit

class MainViewController: UIViewController {
    
    var categories = Regions()
    var categories2 = Continents()
    
    
    // DIREKNO SO SEGUE BEZ VARIJABLA
    @IBAction func btnSelectRegion(_ sender: UIButton) {
//        let dataArray = categories.continent
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard?.instantiateViewController(identifier: "ContinentsViewController") as! ContinentsViewController
//        navigationController?.pushViewController(controller, animated: true)
//        controller.continents = categories2
//        //controller.categories =  categories
        
        performSegue(withIdentifier: "goFurther", sender: nil)
    }
    
    //VARIJABLA I SEGUE
    @IBAction func btnTop(_ sender: Any) {
        let varijabla = "OVA SAKAS DA GO RPEFRLIS"
        performSegue(withIdentifier: "goFurther", sender: varijabla)
    }

    //BEZ SEGUE SO VARIJABLA
    @IBAction func btnBottom(_ sender: Any) {
        let varijabla = "OVA SAKAS DA GO RPEFRLIS"

        // GO ZEMAS STORYBOARD
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        //GO zemas kontrollerot
        let controller = storyBoard.instantiateViewController(withIdentifier: "ContinentsViewController") as! ContinentsViewController
        
        // JA SETIRAS VARIJABLATA 
        controller.varijablaZaPrezemanjeOdMain = varijabla
        
        // PUSH ILI PREZENT
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Proveruvas dali e toa segueto
        if segue.identifier == "goFurther" {
            let controller = segue.destination as! ContinentsViewController
            
            //"OVDE JA SETIRAS VARIJABLATA ZA VO DRUGIOT"
            if let varijabla = sender as? String {
                controller.varijablaZaPrezemanjeOdMain = varijabla // MORA DA JA PRETVOORIS POSO JA PRIMA GORE KAKO ANY 
            }
            
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    

    

}

