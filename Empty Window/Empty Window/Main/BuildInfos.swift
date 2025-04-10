//
//  BuildInfos.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/4/2.
//

import Foundation
import UIKit

class BuildInfo {

    let settingName: String
    let configToValueDic: [String: String]

    private static let keyDebug = "Debug"
    private static let keyRelease = "Release"

    init(settingName: String, configToValueDic: [String: String]) {
        self.settingName = settingName
        self.configToValueDic = configToValueDic

    }

    static func createBuildInfos() -> [BuildInfo] {

        return (0...50).map {_ in
                BuildInfo(
                    settingName: "API_BASE_URL",
                    configToValueDic: [
                        keyDebug: " https://qa.api.example.com",
                        keyRelease: "https://api.example.com",
                    ])
            }
    }
}

class BuildInfosDelegate: NSObject, UITableViewDataSource {

    let buildInfos: [BuildInfo]

    init(buildInfos: [BuildInfo]) {
        self.buildInfos = buildInfos
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return buildInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: BuildInfoCell.reuseIdentifier, for: indexPath)
            as! BuildInfoCell
        let buildInfo = buildInfos[indexPath.row]
        cell.set(buildInfo: buildInfo)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

class BuildInfoCell: UITableViewCell {

    static let reuseIdentifier = "buildInfoCell"

    private let settingNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let configContainer: UIStackView = {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.distribution = .fill
        container.alignment = .fill
        return container
    }()

    private static func createSubLabel(for text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .gray
        return label
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.addSubview(settingNameLabel)
        contentView.addSubview(configContainer)
        let offset = 20.0

        var constranints = [
            settingNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: offset),
            settingNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: offset),
            settingNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -offset),
        ]

        constranints.append(contentsOf: [
            configContainer.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            configContainer.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            configContainer.topAnchor.constraint(
                equalTo: settingNameLabel.bottomAnchor, constant: offset),
            configContainer.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
        ])

        NSLayoutConstraint.activate(constranints)

    }

    func set(buildInfo: BuildInfo) {
        configContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        settingNameLabel.text = buildInfo.settingName
        let offset = 20.0
        for (configName, configValue) in buildInfo.configToValueDic {
            let nameValueContainer = UIView()
            nameValueContainer.translatesAutoresizingMaskIntoConstraints = false
            let configNameLabel = BuildInfoCell.createSubLabel(for: configName)
            let configValueLable = BuildInfoCell.createSubLabel(
                for: configValue)
            nameValueContainer.addSubview(configNameLabel)
            nameValueContainer.addSubview(configValueLable)

            NSLayoutConstraint.activate([
                configNameLabel.topAnchor.constraint(
                    equalTo: nameValueContainer.topAnchor, constant: offset),
                configNameLabel.bottomAnchor.constraint(
                    equalTo: nameValueContainer.bottomAnchor, constant: -offset),
                configNameLabel.leadingAnchor.constraint(
                    equalTo: nameValueContainer.leadingAnchor, constant: offset),

                configValueLable.topAnchor.constraint(
                    equalTo: configNameLabel.topAnchor),
                configValueLable.leadingAnchor.constraint(
                    equalTo: configNameLabel.trailingAnchor, constant: offset),
                configValueLable.trailingAnchor.constraint(
                    equalTo: nameValueContainer.trailingAnchor, constant: -offset),

            ])
            configContainer.addArrangedSubview(nameValueContainer)

        }
    }

    private func generateConstraintsFor(label: UILabel, container: UIView)
        -> [NSLayoutConstraint]
    {
        let offset = 20.0
        return [
            label.topAnchor.constraint(
                equalTo: container.topAnchor, constant: offset),
            label.leadingAnchor.constraint(
                equalTo: container.leadingAnchor, constant: offset),
            label.trailingAnchor.constraint(
                equalTo: container.trailingAnchor, constant: -offset),

        ]
    }

}


class BuildInfosHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "BuildInfosHeader"
    
    
    private let headerLabel: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.font = .boldSystemFont(ofSize: 18.0)
        header.textColor = .systemBlue
        header.text = "Debug"
        return header
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupHeader() {
        contentView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func setHeader(configName: String) {
        headerLabel.text = configName
    }
    
}
