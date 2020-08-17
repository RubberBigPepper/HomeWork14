//
//  LoadWeather.swift
//  HomeWork12
//
//  Created by Albert on 03.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLoader {
    static let OWM_API_KEY : String = "40bc68936e396a347d9231abb5178769"//ключ для доступа к OpenWeatherMap.org API

    func loadWeatherDay(completion: @escaping (WeatherData?) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=\(WeatherLoader.OWM_API_KEY)&lang=ru")!
        let request = URLRequest(url: url)
      //  SVProgressHUD.show()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                    DispatchQueue.main.async {
                        let weather = WeatherData(jsonDict)
                    //    SVProgressHUD.dismiss()
                        completion(weather)
                    }
                }
            }
        task.resume()
    }
    
    func loadWeatherWeek(completion: @escaping ([WeatherData]) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?q=Moscow&nits=metric&cnt=7&appid=\(WeatherLoader.OWM_API_KEY)&lang=ru")!
        let request = URLRequest(url: url)
  //      SVProgressHUD.show()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                    DispatchQueue.main.async {//надо найти массив list - это погода по дням
                        let arrayList = jsonDict["list"] as! NSArray
                        var arWeather : [WeatherData] = []
                        for data in arrayList where data is NSDictionary{
                            let dict = data as! NSDictionary
                            if let weather = WeatherData(dict){
                                arWeather.append(weather)
                            }
                        }
                        // SVProgressHUD.dismiss()
                        completion(arWeather)
                    }
                }
            }
        task.resume()
    }
    
    func loadWeatherDayAlamofire(completion: @escaping (WeatherData?) -> Void){
 //       SVProgressHUD.show()
        let url="https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=\(WeatherLoader.OWM_API_KEY)&lang=ru"
        AF.request(url).responseJSON{ response in
            if let data = response.value,
               let jsonDict = data as? NSDictionary{
                   DispatchQueue.main.async {
                       let weather = WeatherData(jsonDict)
                 //       SVProgressHUD.dismiss()
                       completion(weather)
                   }
               }
           }
   }
   
    func loadWeatherWeekAlamofire(completion: @escaping ([WeatherData]) -> Void){
//        SVProgressHUD.show()
        let url="https://api.openweathermap.org/data/2.5/forecast/daily?q=Moscow&nits=metric&cnt=7&appid=\(WeatherLoader.OWM_API_KEY)&lang=ru"
        AF.request(url).responseJSON{ response in
            if let data = response.value,
               let jsonDict = data as? NSDictionary{
                    let arrayList = jsonDict["list"] as! NSArray
                    var arWeather : [WeatherData] = []
                    for data in arrayList where data is NSDictionary{
                        let dict = data as! NSDictionary
                        if let weather = WeatherData(dict){
                            arWeather.append(weather)
                        }
                    }
                    DispatchQueue.main.async {//надо найти массив list - это погода по дням
                      //  SVProgressHUD.dismiss()
                       completion(arWeather)
                    }
               }
           }
   }
}
