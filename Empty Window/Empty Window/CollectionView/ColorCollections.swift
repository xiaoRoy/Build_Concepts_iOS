//
//  ColorCollections.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/4/30.
//

import Foundation
import UIKit


final class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "color_cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    func config(with color: UIColor) {
        contentView.backgroundColor = color
    }
}
