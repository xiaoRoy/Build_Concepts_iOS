//
//  BuildInfoViewController.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/3/28.
//

import UIKit

class BuildInfoViewController: UIViewController, UITableViewDelegate {
    
    private let buildInfos: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(BuildInfoCell.self, forCellReuseIdentifier: BuildInfoCell.reuseIdentifier)
        return tableView
    }()
    
    private var buildInfoDelegate: BuildInfosDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBuildInfos()
    }
    
    private func setupBuildInfos() {
       
        buildInfoDelegate = BuildInfosDelegate(buildInfos: BuildInfo.createBuildInfos())
        buildInfos.dataSource = buildInfoDelegate
        buildInfos.delegate = self
        view.addSubview(buildInfos)
        let safeAreaLayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            buildInfos.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor),
            buildInfos.bottomAnchor.constraint(equalTo: safeAreaLayout.bottomAnchor),
            buildInfos.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor),
            buildInfos.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor)
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
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
