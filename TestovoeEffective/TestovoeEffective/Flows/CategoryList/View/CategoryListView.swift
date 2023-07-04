//
//  ViewController.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import UIKit
import SnapKit

final class CategoryListView: UIViewController, CategoryListViewProtocol  {
    var presenter: CategoryListPresenterProtocol?
 
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 1000, width: 100, height: 20)
        label.center = CGPoint(x: -112, y: 17)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var currencyData: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 28, width: 280, height: 20)
        label.center = CGPoint(x: -90, y: 40)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private lazy var userIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var locationIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var navItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        navigationItem.titleView = makeNavigationBar(city: "Коломна", data: "15 августа, 2023")
        return navigationItem
    }()
    
    private lazy var navigationBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 70))
        navBar.tintColor = .white
        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    private lazy var categoryList: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: configureLayout()
        )
        collectionView.register(
            CategoryPropertiesCell.self,
            forCellWithReuseIdentifier: CategoryPropertiesCell.reuseID
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        presenter?.viewDidLoad()
        makeContraints()
        setupViews()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(categoryList)
    }
    
    private func setupViews() {
        let rightBarButtonItem = UIBarButtonItem(customView: userIcon)
        let leftBarButtonItem = UIBarButtonItem(customView: locationIcon)
        
        navItem.rightBarButtonItem?.customView?.superview?.backgroundColor = .clear
        navItem.rightBarButtonItem?.tintColor = .white
        navItem.rightBarButtonItem = rightBarButtonItem
        navItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func makeContraints() {
        categoryList.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(148)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 15
        )
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    
    private func makeNavigationBar(city: String, data: String) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        cityName.text = city
        currencyData.text = data
        
        view.addSubview(cityName)
        view.addSubview(currencyData)
        
        return view
    }
    
    func reloadData() {
        categoryList.reloadData()
    }
}

extension CategoryListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter?.сategories?.сategories.count else { return 0 }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryPropertiesCell.reuseID,
            for: indexPath
        ) as! CategoryPropertiesCell
        
        guard let model = presenter?.сategories?.сategories[indexPath.row] else { return cell }
        
        cell.config(model: presenter?.builderForCell(row: model) ?? CategoryModel(id: 0, name: "", image: "") )

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.item) clicked")
        guard let model = presenter?.сategories?.сategories[indexPath.row] else { return }
        guard let title = model.name else { return }

        presenter?.pushDishesListView(title: title)
    }
}

