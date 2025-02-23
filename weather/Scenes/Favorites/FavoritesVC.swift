//
//  ProfileVC.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import UIKit

class FavoritesVC: BaseViewController {
    @IBOutlet weak var locationTf: UITextField!
    @IBOutlet weak var favouritesTableView: UITableView!
    
    var viewModel: FavoritesVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = FavoritesVM()
        setupSideMenu()
        setupForecastTableView()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard let name = locationTf.text else { return }
        
        if name.isEmpty { return }
        
        self.viewModel.fetchWeatherData(location: name)
    }
    
    private
    func setupForecastTableView(){
        self.favouritesTableView.register(FavouriteCell.nib(), forCellReuseIdentifier: FavouriteCell.identifier)
//        favouritesTableView.dataSource = self
        
        viewModel.favouritesList.bind(to: favouritesTableView.rx.items(cellIdentifier: "FavouriteCell", cellType: FavouriteCell.self)) { (row,item,cell) in
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
        
        
        favouritesTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                print("deleted: \(indexPath.row)")
                self.viewModel.removeFavourite(at: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
