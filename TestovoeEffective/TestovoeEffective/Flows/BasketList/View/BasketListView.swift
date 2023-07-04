//
//  BasketListVIew.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation
import UIKit

final class BasketListView: UIViewController, BasketListViewProtocol {
    var presenter: BasketListPresenterProtocol?
    
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
    
    private lazy var basketList: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(BasketListCell.self, forCellReuseIdentifier: BasketListCell.reuseID)
        tableView.sectionHeaderHeight = 1
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.20, green: 0.39, blue: 0.88, alpha: 1.00)
        button.layer.cornerRadius = 10
        button.setTitle("Оплатить 0 ₽", for: .normal)
        return button
    }()
    
    var cost = 0
    var totalCost = 0
    var counter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
        presenter?.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zeroingOut()
    }
    
    private func configUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let headerFooterView = UIView()
        headerFooterView.backgroundColor = .clear
        UITableViewHeaderFooterView.appearance().backgroundView = headerFooterView
        
        view.addSubview(basketList)
        view.addSubview(buyButton)
        view.addSubview(navigationBar)
    }
    
    private func setupViews() {
        let rightBarButtonItem = UIBarButtonItem(customView: userIcon)
        let leftBarButtonItem = UIBarButtonItem(customView: locationIcon)
        
        navItem.rightBarButtonItem?.customView?.superview?.backgroundColor = .clear
        navItem.rightBarButtonItem?.tintColor = .white
        navItem.rightBarButtonItem = rightBarButtonItem
        navItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func updateButtonTitle(totalCost: Double) {
        let buttonText = "Оплатить \(Int(totalCost))"
        buyButton.setTitle(buttonText, for: .normal)
        self.totalCost = Int(totalCost)
    }
    
    private func calculatePriceDishes(price: Int) -> Int {
        cost += price
        
        return cost
    }
    
    private func decrementTotalCost(price: Int) -> Int {
        totalCost -= price
        
        return totalCost
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
    
    private func zeroingOut() {
        cost = 0
    }
    
    private func makeConstraints() {
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(basketList.snp.bottom)
            make.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(343)
            make.height.equalTo(48)
        }
        
        basketList.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func reloadData() {
        basketList.reloadData()
    }
}

extension BasketListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.dishes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketListCell.reuseID, for: indexPath) as! BasketListCell
        guard let dish = presenter?.dishes[indexPath.section] else { return cell }
        guard let model = presenter?.builderForCellInBasket(row: dish) else { return cell }
       
        updateButtonTitle(totalCost: Double(calculatePriceDishes(price: Int(dish.price))))
        
        counter = Int(dish.counter)
        
        cell.delegate = self
        cell.config(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionSpacing: CGFloat = 1
       
        return sectionSpacing
    }
}

extension BasketListView: DidTapStepper {
    func didTap(value: Int, cell: BasketListCell) {
        guard let indexPath = basketList.indexPath(for: cell) else { return }
        
        counter += Int(presenter?.dishes[indexPath.section].counter ?? 0)
        
        if value == 0 {
            updateButtonTitle(totalCost: 0)
        }
        
        presenter?.deleteCell(value: value, name: (presenter?.dishes[indexPath.section].dishName ?? ""), index: indexPath.section)
        
        guard let presenter = presenter else { return }
        guard presenter.dishes.isEmpty != true else { return }
   
        if counter > value {
            updateButtonTitle(totalCost: Double(decrementTotalCost(price: Int(presenter.dishes[indexPath.section].price))))
        } else {
            totalCost += calculatePriceDishes(price: Int(presenter.dishes[indexPath.section].price))
            updateButtonTitle(totalCost: Double(totalCost))
        }
        
        zeroingOut()
    }
}
