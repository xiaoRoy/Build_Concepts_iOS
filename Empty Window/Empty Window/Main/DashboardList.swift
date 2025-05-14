//
//  DashboardList.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/5/3.
//

import Foundation
import UIKit

final class DashboardItemCell: UICollectionViewCell {

    static let reuseIdentifier = "dashborad_item_cell"

    var navigation: (() -> Void)?

    private let actiongButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.addSubview(actiongButton)
        actiongButton.addAction(
            UIAction { [weak self] _ in self?.navigation?() },
            for: .touchUpInside)
        NSLayoutConstraint.activate([
            actiongButton.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor),
            actiongButton.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
        ])
    }

    func config(dashbordItem: DashboardItem) {
        actiongButton.setTitle(dashbordItem.itemName, for: .normal)
        //        actionLabel.text = dashbordItem.itemName
    }

    override func prepareForReuse() {
        navigation = nil
    }
}

final class DashboardItem {

    typealias DashboardNavigayion = () -> Void

    let itemName: String
    let navigation: DashboardNavigayion

    init(itemName: String, navigation: @escaping DashboardNavigayion) {
        self.itemName = itemName
        self.navigation = navigation
    }

    static func generateDashboardItems(controller: UIViewController)
        -> [DashboardItem]
    {
        let dahsboardItemInfos = [
            ("Build Infos", "dashboardToBuildInfo"),
            ("Work Space", "dashboardToWorkSpace"),
            ("Colors Collection", "dashboardToColors")
        ]
        return dahsboardItemInfos.map { (itemName, segueIdentifier) in
            DashboardItem(
                itemName: itemName,
                navigation: generateDashboardNavigation(
                    controller, identifier: segueIdentifier))
        }

    }

    private static func generateDashboardNavigation(
        _ controller: UIViewController, identifier: String, sender: Any? = nil
    )
        -> DashboardItem.DashboardNavigayion
    {

        return { [weak controller] () in
            controller?.performSegue(withIdentifier: identifier, sender: sender)
        }
    }
}

final class DashboardListDelegateLayout: CollectionViewEvenColumnDelegateLayout,
    UICollectionViewDataSource
{
    private let dashboardItems: [DashboardItem]

    init(dashborardItems: [DashboardItem]) {
        self.dashboardItems = dashborardItems
        super.init(numberOfItemsPerRow: 2)
    }

    func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        let dashboardItem = dashboardItems[indexPath.item]
        dashboardItem.navigation()
    }

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        dashboardItems.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: DashboardItemCell.reuseIdentifier,
                for: indexPath)
            as! DashboardItemCell
        let dashboardItem = dashboardItems[indexPath.item]
        cell.config(dashbordItem: dashboardItem)
        cell.navigation = dashboardItem.navigation
        return cell

    }

}
