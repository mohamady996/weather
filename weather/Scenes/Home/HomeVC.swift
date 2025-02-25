//
//  HomeVC.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa

class HomeVC: BaseViewController {
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var viewModel: HomeVM!
    var searchTableViewHeightConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = HomeVM()
        setupSideMenu()
        setupForecastTableView()
        setupSearchTableView()
        setupPullToRefresh()
        bindSearchTF()
    }
    
    private
    func bindSearchTF(){
        self.searchTF.rx.controlEvent(.editingChanged)
            .withLatestFrom(searchTF.rx.text.orEmpty)
            .subscribe(onNext: { (text) in
                self.searchTableView.isHidden = false
                self.viewModel.fetchSearchData(search: text)
            })
            .disposed(by: disposeBag)
    }
    
    private
    func setupPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        forecastTableView.addSubview(refreshControl)
        
        self.viewModel.weatherforecast.subscribe(onNext: {_ in 
            self.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
        
    }
    
    @objc
    private
    func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.viewModel.pulledToRefreshAction()
        self.searchTableView.isHidden = true
        self.searchTF.text = ""
    }
    
    private
    func setupForecastTableView(){
        self.forecastTableView.register(weatherCell.nib(), forCellReuseIdentifier: weatherCell.identifier)
        
        viewModel.weatherforecast.bind(to: forecastTableView.rx.items(cellIdentifier: "weatherCell", cellType: weatherCell.self)) { (row,item,cell) in
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
    }
    
    private
    func setupSearchTableView(){
        // Height constraint (will be updated dynamically)
        searchTableViewHeightConstraint = searchTableView.heightAnchor.constraint(equalToConstant: 0)
        searchTableViewHeightConstraint.isActive = true
        
        // Register default cell
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        viewModel.searchArray.bind(to: searchTableView.rx.items(cellIdentifier: "cell")) { _, item, cell in
            cell.textLabel?.text = item.name
        }
        .disposed(by: disposeBag)
        
        // Handle item selection
        searchTableView.rx.modelSelected(SearchResponseModelElement.self)
            .subscribe(onNext: { selectedItem in
                self.viewModel.fetchWeatherData(location: selectedItem.name ?? "")
                self.searchTableView.isHidden = true
                self.searchTF.text = selectedItem.name ?? ""
            })
            .disposed(by: disposeBag)
        
        // Observe changes and update table height dynamically
        self.viewModel.searchArray.subscribe(onNext: { [weak self] _ in
            self?.updateSearchTableHeight()
        })
        .disposed(by: disposeBag)

    }
    
    private
    func updateSearchTableHeight() {
        searchTableView.layoutIfNeeded()
        searchTableViewHeightConstraint.constant = searchTableView.contentSize.height
    }
}
