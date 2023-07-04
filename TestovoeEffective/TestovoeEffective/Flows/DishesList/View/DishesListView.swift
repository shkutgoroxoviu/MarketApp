//
//  DishesListView.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation
import UIKit

final class DishesListView: UIViewController, DishesListViewProtocol {
    var presenter: DishesListPresenterProtocol?
    
    var condition: Bool = false
    
    var dishName = ""
    
    var bool: Bool?
    
    private lazy var tegsMenu: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: configureLayoutTegs()
        )
        collectionView.register(
            TegCell.self,
            forCellWithReuseIdentifier: TegCell.reuseID
        )
    
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var dishesList: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: configureLayoutDishesList()
        )
        collectionView.register(
            DishPropertyCell.self,
            forCellWithReuseIdentifier: DishPropertyCell.reuseID
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var userIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var popUpView: PopUpWindowView = {
        let view = PopUpWindowView()
        view.isHidden = true
//        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configUI()
        setItemsInNavigationController()
        makeContraints()
    }
    
    @objc private func tapBack() {
        navigationController?.popToRootViewController(animated: true)
    }
   
    func config(title: String) {
        self.title = title
    }
    
    private func configUI() {
        hidesBottomBarWhenPushed = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.black
    
        view.addSubview(dishesList)
        view.addSubview(tegsMenu)
    }
    
    private func setItemsInNavigationController() {
        let rightBarButtonItem = UIBarButtonItem(customView: userIcon)
        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.rightBarButtonItem?.customView?.superview?.backgroundColor = .clear
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func makeContraints() {
        dishesList.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(tegsMenu.snp.bottom).offset(10)
        }
        
        tegsMenu.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func configureLayoutTegs() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(50),
            heightDimension: .estimated(50)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 4)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = .init(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 10
        )
        
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
            layoutConfiguration.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(section: section, configuration: layoutConfiguration)
    }
    
    private func configureLayoutDishesList() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .absolute((view.frame.width / 3) - 15),
            heightDimension: .estimated(170)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 3)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        
        section.contentInsets = .init(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 10
        )
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func presentToPopUpWindow(model: DishModel) {
        let popUpWindow = PopUpWindow()
        popUpWindow.modalPresentationStyle = .overFullScreen
        popUpWindow.modalTransitionStyle = .crossDissolve
        popUpWindow.config(dishName: model.name, price: model.price, weight: model.weight, image: model.image, description: model.description)
        popUpWindow.delegate = self
        
        self.present(popUpWindow, animated: true)
    }
    
    func reloadData() {
        dishesList.reloadData()
    }
}

extension DishesListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dishesList {
            if condition == false {
                return presenter?.currentList.count ?? 0
            } else {
                return presenter?.tegList.count ?? 0
            }
        } else if collectionView == tegsMenu {
            return presenter?.tegs.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dishesList {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DishPropertyCell.reuseID,
                for: indexPath
            ) as! DishPropertyCell
            
            if condition == false {
                guard let model = presenter?.currentList[indexPath.row] else { return cell }
                cell.config(model: presenter?.builderForCell(row: model) ?? DishModel(name: "", price: 0, weight: 0, image: "", description: "", id: 0))
            } else {
                guard let model = presenter?.tegList[indexPath.row] else { return cell }
                cell.config(model: presenter?.builderForCell(row: model) ?? DishModel(name: "", price: 0, weight: 0, image: "", description: "", id: 0))
            }
            
            return cell
        } else if collectionView == tegsMenu {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TegCell.reuseID,
                for: indexPath
            ) as! TegCell
            
            guard let teg = presenter?.tegs[indexPath.row] else { return cell }
            cell.config(model: teg)
            if indexPath.row == 0 {
                cell.isSelected = true
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.item) clicked")
        if collectionView == dishesList {
            if condition == false {
                guard let model = presenter?.currentList[indexPath.row] else { return }
                let popUpWindowModel = DishModel(name: model.name, price: model.price, weight: model.weight, image: model.imageURL, description: model.description, id: 0)
                dishName = model.name
                presentToPopUpWindow(model: popUpWindowModel)
            } else {
                guard let modelTeg = presenter?.tegList[indexPath.row] else { return }
                let popUpWindowModel = DishModel(name: modelTeg.name, price: modelTeg.price, weight: modelTeg.weight, image: modelTeg.imageURL, description: modelTeg.description, id: 0)
                dishName = modelTeg.name
                presentToPopUpWindow(model: popUpWindowModel)
            }
            
        } else if collectionView == tegsMenu {
            let cell = collectionView.cellForItem(at: indexPath) as? TegCell
            cell?.isCellSelected = true
            
            switch indexPath.row {
            case 0:
                presenter?.sortDishesByTeg(teg: Teg.всеМеню, index: 0)
                condition = true
            case 1:
                presenter?.sortDishesByTeg(teg: Teg.салаты, index: 1)
                condition = true
            case 2:
                presenter?.sortDishesByTeg(teg: Teg.сРисом, index: 2)
                condition = true
            default:
                presenter?.sortDishesByTeg(teg: Teg.сРыбой, index: 3)
                condition = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TegCell
        cell?.isCellSelected = false
    }
}

extension DishesListView: AcceptInfo {
    func accept(bool: Bool) {
        presenter?.changeStatus(dishName: dishName, bool: bool)
    }
}
