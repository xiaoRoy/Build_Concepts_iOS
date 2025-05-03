//
//  ColorsViewController.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/4/30.
//

import UIKit

class ColorsViewController: UIViewController {

    private let colors: [UIColor] = {

        return stride(from: 0, to: 255, by: 15).map { green in
            UIColor(red: 1.0, green: green / 255.0, blue: 0.0, alpha: 1.0)

        }
    }()

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = 10.0
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(
            top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()

    private lazy var colorCollection: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            ColorCell.self,
            forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        return collectionView
    }()

    private let colorCollectionViewDelegate = ColorCollectionViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        colorCollection.dataSource = self
        colorCollection.delegate = colorCollectionViewDelegate

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func initCollectionView() {
        let layoutMarginGuide = view.layoutMarginsGuide
        let insetOffset = 0.0
        view.addSubview(colorCollection)
        NSLayoutConstraint.activate([
            colorCollection.leadingAnchor.constraint(
                equalTo: layoutMarginGuide.leadingAnchor, constant: insetOffset),
            colorCollection.trailingAnchor.constraint(
                equalTo: layoutMarginGuide.trailingAnchor,
                constant: -insetOffset),
            colorCollection.topAnchor.constraint(
                equalTo: layoutMarginGuide.topAnchor, constant: insetOffset),
            colorCollection.bottomAnchor.constraint(
                equalTo: layoutMarginGuide.bottomAnchor, constant: -insetOffset),
        ])
    }
}

extension ColorsViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        colors.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath)
            as! ColorCell
        cell.config(with: colors[indexPath.item])
        return cell

    }

}

class ColorCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout
{

    let numberOfItemsPerRow: CGFloat = 2

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard
            let collectionViewFlowLayout = collectionViewLayout
                as? UICollectionViewFlowLayout
        else {
            return .zero
        }

        let totalSpacing =
            collectionViewFlowLayout.sectionInset.left
            + collectionViewFlowLayout.sectionInset.right
            + (numberOfItemsPerRow - 1)
            * collectionViewFlowLayout.minimumInteritemSpacing
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = availableWidth / numberOfItemsPerRow
//        let scale = CGFloat.random(in: 0.0...1.0)
//        let heightScale = CGFloat.random(in: 0.0...1.0)
        return CGSize(width: itemWidth , height: itemWidth)
    }
}
