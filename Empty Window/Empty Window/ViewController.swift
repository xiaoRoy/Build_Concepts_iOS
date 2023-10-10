//
//  ViewController.swift
//  Empty Window
//
//  Created by jerli on 2022/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    let locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction
    func requestLocationWhenInUse(_ button: UIButton) {
        print("Request Location")
        locationManager.requestWhenInUseLocationAuthorization()
    }
    
    @IBAction
    func requestLocationAlways(_ button: UIButton) {
        locationManager.requestAlwaysAuthorization()
    }
    
    
    @IBAction
    func showAlert(_ button: UIButton) {
        let defaultAction = UIAlertAction(title: "Agree",
                             style: .default) { (action) in
         // Respond to user selection of the action.
        }
        let cancelAction = UIAlertAction(title: "Disagree",
                             style: .cancel) { (action) in
         // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Terms and Conditions",
              message: "Click Agree to accept the terms and conditions.",
              preferredStyle: .alert)
        
       
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
//        alert.preferredAction = alert.actions[0]
        
        self.present(alert, animated: true) {
           // The alert was presented
        }
    }
}

