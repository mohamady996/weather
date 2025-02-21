//
//  weatherCell.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import UIKit

class weatherCell: UITableViewCell {
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var temperatureLb: UILabel!
    @IBOutlet weak var humidityLb: UILabel!
    @IBOutlet weak var windSpeedLb: UILabel!
    @IBOutlet weak var weatherConditionLb: UILabel!
    @IBOutlet weak var weatherConditionImg: UIImageView!
    
    static let identifier = "weatherCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "weatherCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: ForecastModel){
        
        let temp = (getBoolFromUserDefaults(name: .tempAsCelcius) ?? true) ? "\(model.tempC ?? 0.0) C" : "\(model.tempF ?? 0.0) F"
        
        self.dateLb?.text = model.date
        self.temperatureLb?.text = temp
        self.humidityLb?.text = String(model.humidity ?? 0)
        self.windSpeedLb?.text = String(model.windKph ?? 0.0)
        self.weatherConditionLb?.text = model.condition
        self.weatherConditionImg.downloaded(from: model.conditionIconURL ?? "")
    }
    
    private
    func getBoolFromUserDefaults(name: savedObjects) -> Bool? {
        return UserDefaults.standard.bool(forKey: name.rawValue) //Bool
    }

}
