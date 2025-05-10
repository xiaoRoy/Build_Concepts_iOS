//
//  DashboardViewController.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/3/28.
//

import UIKit

class DashboardViewController: UIViewController {

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = 10.0
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(
            top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()

    private lazy var container: UICollectionView = {
        let container = UICollectionView(
            frame: .zero, collectionViewLayout: self.flowLayout)
        container.translatesAutoresizingMaskIntoConstraints = false
        //        container.backgroundColor = .darkGray
        container.register(
            DashboardItemCell.self,
            forCellWithReuseIdentifier: DashboardItemCell.reuseIdentifier)
        return container
    }()

    private lazy var dashboardItems: [DashboardItem] = {
        let buildInfoItem = DashboardItem(
            itemName: "Build Info",
            navigation: self.generateDashboardNavigation(
                identifier: "dashboardToBuildInfo", sender: nil))
        return [buildInfoItem]
    }()

    private var colorCollectionViewDelegate: DashboardListDelegateLayout!

    private func generateDashboardNavigation(identifier: String, sender: Any?)
        -> DashboardItem.DashboardNavigayion
    {
        return { [weak self] () in
            self?.performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollectionViewDelegate = DashboardListDelegateLayout(
            dashborardItems: dashboardItems)
        setupContainer()

        // Do any additional setup after loading the view.
    }

    private func setupContainer() {

        container.delegate = colorCollectionViewDelegate
        container.dataSource = colorCollectionViewDelegate
        let layoutMarginGuide = view.layoutMarginsGuide
        let insetOffset = 0.0
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(
                equalTo: layoutMarginGuide.leadingAnchor, constant: insetOffset),
            container.trailingAnchor.constraint(
                equalTo: layoutMarginGuide.trailingAnchor,
                constant: -insetOffset),
            container.topAnchor.constraint(
                equalTo: layoutMarginGuide.topAnchor, constant: insetOffset),
            container.bottomAnchor.constraint(
                equalTo: layoutMarginGuide.bottomAnchor, constant: -insetOffset),
        ])
    }

    //    @IBAction
    //    func navigateToBuildState() {
    //
    //        performSegue(withIdentifier: "ShowBuildInfo", sender: nil)
    //    }
    //

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - PAID version
    func setupPaidVersionEntrance() {

    }

}

//extension DashboardViewController: UICollectionViewDataSource {
//    func collectionView(
//        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
//    ) -> Int {
//        dashboardItems.count
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let cell =
//            collectionView.dequeueReusableCell(
//                withReuseIdentifier: DashboardItemCell.reuseIdentifier,
//                for: indexPath)
//            as! DashboardItemCell
//        let dashboardItem = dashboardItems[indexPath.item]
//        cell.config(dashbordItem: dashboardItem)
//        return cell
//
//    }
//}
