//
//  ViewController.swift
//  HomeWork12
//
//  Created by Albert on 03.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAlamofire: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var weatherContainerView: UIView!
    
    private var weatherCellView : WeatherCellView?

    @IBOutlet weak var tableView: UITableView!
    
    var weatherArray : [WeatherData] = []{
        didSet{//перегрузим данные таблицы
            self.tableView.reloadData()
        }
    }

    var weatherCurrent : WeatherData? = nil{//погода текущая
        didSet{//тут надо перегрузить данные во вьюшках
            weatherCellView?.setWeather(weatherCurrent)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.dataSource = self
        
        weatherCellView = WeatherCellView.loadViewFromNib()//привяжем наш XIB ко вью в сториборде
        weatherCellView?.frame=weatherContainerView.bounds
        weatherContainerView.addSubview(weatherCellView!)
        ReadFromRealm()//поднимем из сохраненных данных
        getCurrentWeather()
        getWeekWeather()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SaveToRealm() //сохраним погоду
    }


    private func getCurrentWeather(){
        WeatherLoader().loadWeatherDayAlamofire {weather in
            self.weatherCurrent=weather
        }
    }
    
    private func getWeekWeather(){
        WeatherLoader().loadWeatherWeekAlamofire {weather in
            self.weatherArray=weather
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {//проверим, что это нужная таблица (на случай если их несколько)
        case self.tableView:
           return self.weatherArray.count//количество данных в таблице
         default:
           return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! TableViewCell
        cell.setWeather(self.weatherArray[indexPath.row])
        return cell
    }
    
    
    public func SaveToRealm(){//кэшируем в базу
        let realm = try! Realm()
        try! realm.write{
            for weather in weatherArray{
                realm.add(weather)
            }
        }
    }
    
    public func ReadFromRealm(){//чтение из кеша
        let realm = try! Realm()
        weatherArray.removeAll()
        let weatherList=realm.objects(WeatherData.self)//читаем объекты
        for weather in weatherList{
            self.weatherArray.append(weather)
        }
    }
    
}

