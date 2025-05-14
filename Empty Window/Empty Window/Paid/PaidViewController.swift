//
//  PaidViewController.swift
//  Empty Window Paid
//
//  Created by Jerry Li on 2025/5/11.
//

import UIKit

class PaidViewController: UIViewController {
    
    private let paidLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a premiunm feature!"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        // Do any additional setup after loading the view.
    }
    
    private func initView() {
        view.addSubview(paidLabel)
        let marginGuide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            paidLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            paidLabel.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor),
        ])
        
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
