//
//  PopUpView.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation
import UIKit

protocol DidTapCloseButton: AnyObject {
    func didTapClose(bool: Bool)
}

protocol DidTapBasketButton: AnyObject {
    func didTapBasket(bool: Bool)
}


class PopUpWindowView: UIView {
    let BorderWidth: CGFloat = 2.0
    
    weak var delegate: DidTapCloseButton?
    weak var delegate1: DidTapBasketButton?
    
    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dishImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var dishName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var priceAndWeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionDish: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.20, green: 0.39, blue: 0.88, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Добавить в корзину", for: .normal)
        button.addTarget(self, action: #selector(tapAddBasketFunc), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "fav"), for: .normal)
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundViewForImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        popupView.addSubview(dishName)
        popupView.addSubview(backgroundViewForImage)
        popupView.addSubview(basketButton)
        popupView.addSubview(descriptionDish)
        popupView.addSubview(priceAndWeight)
        backgroundViewForImage.addSubview(dishImage)
        backgroundViewForImage.addSubview(closeButton)
        backgroundViewForImage.addSubview(favoriteButton)
        addSubview(popupView)
        
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapCloseButton() {
        !closeButton.isSelected ? delegate?.didTapClose(bool: true) : delegate?.didTapClose(bool: false)
    }
    
    @objc private func tapFavoriteButton() {
        changeFavImage()
    }
    
    @objc private func tapAddBasketFunc() {
        delegate1?.didTapBasket(bool: !basketButton.isSelected)
    }
   
    private func changeFavImage() {
        if favoriteButton.imageView?.image == UIImage(named: "fav") {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "fav"), for: .normal)
        }
    }
    
    func config(model: DishModel) {
        dishName.text = model.name
        dishImage.load(urlString: model.image, key: model.id)
        descriptionDish.text = model.description
        priceAndWeight.text = "\(model.price) ₽ · \(model.weight)г"
     }
    
    private func makeConstraints() {
        popupView.snp.makeConstraints { make in
            make.height.equalTo(446)
            make.width.equalTo(343)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        backgroundViewForImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(232)
            make.width.equalTo(311)
        }
        
        dishImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(favoriteButton.snp.trailing).offset(5)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        dishName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(backgroundViewForImage.snp.bottom).offset(10)
        }
        
        priceAndWeight.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(dishName.snp.bottom).offset(5)
        }
        
        descriptionDish.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(priceAndWeight.snp.bottom).offset(5)
        }
        
        basketButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(descriptionDish.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
    }
}
