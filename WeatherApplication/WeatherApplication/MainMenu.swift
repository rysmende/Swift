//
//  ViewController.swift
//  WeatherApplication
//
//  Created by ITLabAdmin on 11/13/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    var welcome:Welcome? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3"
        guard let url = URL(string: urlString ) else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                self.welcome = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    self.display()
                }
                let queue = OperationQueue.main
                queue.addOperation {
                    self.viewWillAppear(true)
                }
            } catch let jsonErr{
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return welcome!.cnt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FutureWeatherCell
        let fullTime    = welcome?.list[indexPath.row].dt_txt
        let fullTimeArr = fullTime?.components(separatedBy: " ")
        
        let date = String((fullTimeArr?[0].suffix(5))!)
        let time = String((fullTimeArr?[1].prefix(5))!)
        cell.time.text = "\(date) \(time)"
    switch(welcome?.list[indexPath.row].weather[0].main){
        case "Thunderstorm":
            cell.icon.image = UIImage(named: "thunderstorm")
        case "Drizzle":
            cell.icon.image = UIImage(named: "sleet")
        case "Rain":
            cell.icon.image = UIImage(named: "rain")
        case "Clear":
            cell.icon.image = UIImage(named: "sunny")
        case "Snow":
            cell.icon.image = UIImage(named: "snow")
        case "Clouds":
            cell.icon.image = UIImage(named: "cloudy")
        default:
            cell.icon.image = UIImage(named: "wind")
        }
        cell.temp.text = "\(Int((welcome?.list[indexPath.row].main.temp)! - 273.15)) °C"
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func display(){
        city.text = welcome?.city.name
        temperature.text = "\(Int((welcome?.list[0].main.temp)! - 273.15)) °C"
        switch welcome?.list[0].weather[0].main {
        case "Thunderstorm":
            weatherIcon.image = UIImage(named: "thunderstorm")
        case "Drizzle":
            weatherIcon.image = UIImage(named: "sleet")
        case "Rain":
            weatherIcon.image = UIImage(named: "rain")
        case "Clear":
            weatherIcon.image = UIImage(named: "sunny")
        case "Snow":
            weatherIcon.image = UIImage(named: "snow")
        case "Clouds":
            weatherIcon.image = UIImage(named: "cloudy")
        default:
            weatherIcon.image = UIImage(named: "wind")
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(white: 1, alpha: 0.01)
        tableView.reloadData()
    }
   
}

