//
//  WeatherCellView.swift
//  HomeWork12
//
//  Created by Albert on 04.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit

class WeatherCellView: UIView {//класс, ответственный за вывод данных о погоде
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    
    public func setWeather(_ weather: WeatherData?){
        if weather == nil { return }
        labelDescription.text = weather!.description
        labelTemperature.text = String(format: "Температура: %.0f °", weather!.temperature>100 ? (weather!.temperature-273.15) : weather!.temperature)
        labelWind.text = String(format: "Ветер: %.f м/с", weather!.windSpeed)
        let url = URL(string: "https://openweathermap.org/img/wn/\(weather!.icon)@2x.png")!
        imageViewIcon.load(url: url)
    }
    
    static func loadViewFromNib() -> WeatherCellView {
        let nib = UINib(nibName: "WeatherCellView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! WeatherCellView
        view.layer.cornerRadius = 10
        return view
    }
}

extension UIImageView {//загрузка имиджа из интернетов
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
