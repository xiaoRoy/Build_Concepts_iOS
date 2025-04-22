//
//  WorkSpaceViewController.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/4/19.
//

import UIKit
import NetworkService
import RemoteConfig

class WorkSpaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        login()
        fetchRemoteConfigs()
        // Do any additional setup after loading the view.
    }
    
    private func login() {
        let loginService = LoginService()
        let token = loginService.login(email: "not@emailc.com", password: "as_pass")
        print(token)
    }
    
    private func fetchRemoteConfigs() {
        let remoteConfig = RemoteConifg()
        let remoteConifgs = remoteConfig.fetchRemoteConfigs()
        print(remoteConifgs)
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
