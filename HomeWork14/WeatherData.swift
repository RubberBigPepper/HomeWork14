//
//  WeatherData.swift
//  HomeWork12
//
//  Created by Albert on 03.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object {//класс погоды
    @objc dynamic var temperature : Double = 0.0//температура
    @objc dynamic var humidity : Double = 0.0 //влажность
    @objc dynamic var pressure : Double = 0.0 //давление
    @objc dynamic var windSpeed : Double = 0.0 //Скорость ветра
    @objc dynamic var windDegree : Double = 0.0 //направление ветра
    @objc dynamic var weather : String = ""//погода
    @objc dynamic var descriptionWheather : String = "" //описание погоды
    @objc dynamic var icon : String = "" //иконка погоды
    
    init?(_ data: NSDictionary){
        guard let weather = data["weather"] as? [NSDictionary] // Dictionary<String, Any> вот тут похоже может вылезти много ошибок в будущем
            else{
                return nil
        }

        let main = data["main"] as? NSDictionary
        let wind = data["wind"] as? NSDictionary
        
        let weatherOne = weather[0]
        self.weather = weatherOne["main"] as! String //слишком лихо сразу в строку, а если не получится? либо делать через guard?
        self.descriptionWheather = weatherOne["description"] as! String
        self.icon = weatherOne["icon"] as! String

        if main != nil {//текущий прогноз
            self.temperature = main!["temp"] as! Double
            self.humidity = main!["humidity"] as! Double
            self.pressure = main!["pressure"] as! Double
        }
        else{//иначе список прогнозов, и тут немного другая структура
            let temp = data["temp"] as! NSDictionary
            self.temperature = temp["day"] as! Double
            self.humidity = data["humidity"] as! Double
            self.pressure = data["pressure"] as! Double
        }
        
        if wind != nil{
            self.windSpeed = wind!["speed"] as! Double
            self.windDegree = wind!["deg"] as! Double
        }
        else{
            self.windSpeed = data["speed"] as! Double
            self.windDegree = data["deg"] as! Double
        }
    }
    
    required init() {
        //fatalError("init() has not been implemented")
    }
}
