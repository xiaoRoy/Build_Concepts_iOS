//
//  SnapkitViewController.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/5/29.
//

import UIKit
import SnapKit

class SnapkitViewController: UIViewController {
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SnapkitViewController-viewDidLoad")
        setupContainer()
        // Do any additional setup after loading the view.
    }
    
    private func setupContainer() {
        print("setupContainer")
        view.addSubview(container)
        container.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50.0)
            make.center.equalTo(self.view)
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
