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

        tableView.register(
            BuildInfoCell.self,
            forCellReuseIdentifier: BuildInfoCell.reuseIdentifier)
        //        tableView.tableHeaderView = BuildInfosHeader()
        //        tableView.register(BuildInfosHeader.self, forCellReuseIdentifier: BuildInfosHeader.reuseIdentifier)
        return tableView
    }()

    private let builfInfosHeader: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private let headerLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .boldSystemFont(ofSize: 20.0)
        lable.textColor = .cyan
        return lable
    }()

    private var buildInfoDelegate: BuildInfosDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeaderView()
        setupBuildInfos()

    }

    private func setupBuildInfos() {

        buildInfoDelegate = BuildInfosDelegate(
            buildInfos: BuildInfo.createBuildInfos())
        buildInfos.dataSource = buildInfoDelegate
        buildInfos.delegate = self
        view.addSubview(buildInfos)
        let safeAreaLayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            buildInfos.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor),
            buildInfos.bottomAnchor.constraint(
                equalTo: safeAreaLayout.bottomAnchor),
            buildInfos.leadingAnchor.constraint(
                equalTo: safeAreaLayout.leadingAnchor),
            buildInfos.trailingAnchor.constraint(
                equalTo: safeAreaLayout.trailingAnchor),
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
    func tableView(
        _ tableView: UITableView, willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }

    //    private func configHeaderView() {
    //        headerLable.text = "Degbug"
    //
    //
    //        builfInfosHeader.addSubview(headerLable)
    //
    //        NSLayoutConstraint.activate([
    //            headerLable.topAnchor.constraint(equalTo: builfInfosHeader.topAnchor, constant: 20.0),
    //            headerLable.bottomAnchor.constraint(equalTo: builfInfosHeader.bottomAnchor, constant: -20.0),
    //            headerLable.leadingAnchor.constraint(equalTo: builfInfosHeader.leadingAnchor, constant: 20.0),
    //            headerLable.trailingAnchor.constraint(equalTo: builfInfosHeader.trailingAnchor, constant: -20.0),
    //
    //        ])
    ////        builfInfosHeader.frame = CGRect(x: 0.0, y: 0.0, width: buildInfos.bounds.width, height: 64.0)
    ////        builfInfosHeader.setNeedsLayout()
    ////        builfInfosHeader.layoutIfNeeded()
    //        buildInfos.tableHeaderView = builfInfosHeader
    //
    //
    //    }

    private func configHeaderView() {
        builfInfosHeader.addSubview(headerLable)
        headerLable.text = "Degbug"

        NSLayoutConstraint.activate([
            headerLable.topAnchor.constraint(
                equalTo: builfInfosHeader.topAnchor, constant: 20.0),
            headerLable.leadingAnchor.constraint(
                equalTo: builfInfosHeader.leadingAnchor, constant: 20.0),
            headerLable.trailingAnchor.constraint(
                equalTo: builfInfosHeader.trailingAnchor, constant: -20.0),
            headerLable.bottomAnchor.constraint(
                equalTo: builfInfosHeader.bottomAnchor, constant: -20.0),
        ])

        builfInfosHeader.setNeedsLayout()
        builfInfosHeader.layoutIfNeeded()

        
        //        let size = builfInfosHeader.systemLayoutSizeFitting(
        //            CGSize(width: buildInfos.bounds.width, height: 0),
        //            withHorizontalFittingPriority: .required,
        //            verticalFittingPriority: .fittingSizeLevel
        //        )
        let size = builfInfosHeader.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize)
        builfInfosHeader.frame = CGRect(
            x: 0, y: 0, width: buildInfos.bounds.width, height: size.height)

        buildInfos.tableHeaderView = builfInfosHeader
    }
}
