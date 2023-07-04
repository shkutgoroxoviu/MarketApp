//
//  CategoryPropertiesCell.swift
//  TestovoeEffective
//
//  Created by Oleg on 29.06.2023.
//

import Foundation
import UIKit

final class CategoryPropertiesCell: UICollectionViewCell {
    static let reuseID = "CategoryPropertiesCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categoryImage: CustomImageView = {
        let image = CustomImageView()
        return image
    }()
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    func configUI() {
        contentView.addSubview(categoryImage)
        categoryImage.addSubview(categoryName)
        makeConstraints()
    }
    
    func config(model: CategoryModel) {
        categoryName.text = model.name
        categoryImage.load(urlString: model.image, key: model.id)
    }
    
    private func makeConstraints() {
        categoryImage.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        categoryName.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(15)
            make.width.equalTo(160)
        }
    }
}
