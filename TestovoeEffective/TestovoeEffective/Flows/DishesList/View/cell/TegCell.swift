//
//  CategoryNameCell.swift
//  TestovoeEffective
//
//  Created by Oleg on 30.06.2023.
//

import Foundation
import UIKit

class TegCell: UICollectionViewCell {
    static let reuseID = "TegCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCellSelected: Bool = false {
            didSet {
                updateCellAppearance()
            }
        }
    
    private lazy var teg: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    func configUI() {
        contentView.addSubview(teg)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        makeConstraints()
    }
    
    func config(model: String) {
        teg.text = model
    }
    
    
    private func updateCellAppearance() {
        contentView.backgroundColor = isSelected ? UIColor(red: 0.20, green: 0.39, blue: 0.88, alpha: 1.00) : UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1.00)
        teg.textColor = isSelected ? .white : .black
    }
    
    private func makeConstraints() {
        teg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
