//
//  DishPropertyCell.swift
//  TestovoeEffective
//
//  Created by Oleg on 30.06.2023.
//

import Foundation
import UIKit

class DishPropertyCell: UICollectionViewCell {
    static let reuseID = "DishPropertyCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dishImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        image.contentMode = .scaleAspectFit
        image.preservesSuperviewLayoutMargins = false
        return image
    }()
    
    private lazy var dishName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backgroundViewForImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        return view
    }()
    
    func configUI() {
        contentView.addSubview(dishName)
        contentView.addSubview(backgroundViewForImage)
        backgroundViewForImage.addSubview(dishImage)
        self.layer.cornerRadius = 10
        makeConstraints()
    }
    
    func config(model: DishModel) {
        dishName.text = model.name
        dishImage.load(urlString: model.image, key: model.id)
    }
    
    private func makeConstraints() {
        backgroundViewForImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(dishName.snp.top)
            make.height.equalTo(123)
        }
        
        dishImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(5)
        }
        
        dishName.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
