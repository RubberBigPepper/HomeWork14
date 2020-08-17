//
//  TableViewCell.swift
//  HomeWork12
//
//  Created by Albert on 04.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    private var weatherView : WeatherCellView? = nil{
        didSet{
            if self.weatherView == nil { return }
            self.weatherView!.frame = bounds
            addSubview(self.weatherView!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.weatherView = WeatherCellView.loadViewFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWeather(_ weather: WeatherData){
        weatherView?.setWeather(weather)
    }

}
