//
//  BasketListCell.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation
import UIKit

protocol DidTapIncrement: AnyObject {
    func didTapIncrement(value: Int, cell: BasketListCell)
}

protocol DidTapDecrement: AnyObject {
    func didTapDecrement(value: Int, cell: BasketListCell)
}

final class BasketListCell: UITableViewCell {
    static let reuseID = "BasketListCell"
    
    weak var delegateIncrement: DidTapIncrement?
    weak var delegateDecrement: DidTapDecrement?
    
    private lazy var dishImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var backgroundViewForImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dishName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var priceAndWeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var dishStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.stepValue = 1
        stepper.value = 0
        stepper.isContinuous = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .touchUpInside)
        
        return stepper
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()

        return label
    }()
    
    var previousValue: Double = 0.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.selectionStyle = .none
        
        contentView.addSubview(dishName)
        contentView.addSubview(priceAndWeight)
        contentView.addSubview(dishStepper)
        contentView.addSubview(backgroundViewForImage)
        backgroundViewForImage.addSubview(dishImage)
        dishStepper.addSubview(counter)
    }
    
    func config(model: BasketListCellModel) {
        dishImage.load(urlString: model.image, key: 0)
        dishName.text = model.dishName
        counter.text = "\(model.counter)"
        priceAndWeight.text = "\(model.price) ₽ · \(model.weight)г"
        dishStepper.value = Double(model.counter)
    }
    
    private func makeConstraints() {
        backgroundViewForImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.equalTo(62)
            make.width.equalTo(62)
        }
        
        dishImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        dishName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(backgroundViewForImage.snp.trailing).offset(5)
        }
        
        priceAndWeight.snp.makeConstraints { make in
            make.leading.equalTo(backgroundViewForImage.snp.trailing).offset(5)
            make.top.equalTo(dishName.snp.bottom).offset(5)
        }
        
        dishStepper.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        counter.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let value = sender.value
        print("New value: \(value)")
        counter.text = String(Int(value))
//        delegateIncrement?.didTapIncrement(value: Int(value), cell: self)
        
        if sender.value > previousValue {
            delegateIncrement?.didTapIncrement(value: Int(value), cell: self)
        } else {
            delegateDecrement?.didTapDecrement(value: Int(value), cell: self)
        }
        
        previousValue = value
    }
}
