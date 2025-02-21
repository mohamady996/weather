//
//  ProfileVC.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class SettingsVC: BaseViewController {

    var viewModel: SettingsVM!
    
    @IBOutlet weak var temperatureUnitSwitch: UISwitch!
    @IBOutlet weak var defaultCityTf: UITextField!
    @IBOutlet weak var appVersionLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = SettingsVM()
        setupSideMenu()
        setupUI()
        bindViews()
    }
    
    private
    func setupUI(){
        //sets the temperature Unit as the saved unit (Celsius by default)
        temperatureUnitSwitch.isOn = viewModel.getBoolFromUserDefaults(name: .tempAsCelcius) ?? true
        
        //sets the default city as the saved value (empty by default)
        defaultCityTf.text = viewModel.getStringFromUserDefaults(name: .defaultCity) ?? ""
        
        //shows the app version
        appVersionLb.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    private
    func bindViews(){
        temperatureUnitSwitch.addTarget(self, action: #selector(handleTemperatureUnitSwitch), for: .valueChanged)
        
        defaultCityTf.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(defaultCityTf.rx.text.orEmpty)
            .subscribe(onNext: { (text) in
                self.viewModel.saveStringToUserDefaults(value: text, name: .defaultCity)
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    private
    func handleTemperatureUnitSwitch(){
        viewModel.saveBoolToUserDefaults(value: temperatureUnitSwitch.isOn, name: .tempAsCelcius)
    }
}
