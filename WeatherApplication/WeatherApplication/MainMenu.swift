//
//  ViewController.swift
//  WeatherApplication
//
//  Created by ITLabAdmin on 11/13/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit
// MARK: - Welcome
struct Welcome: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Int
}

class MainMenu: UIViewController{
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=42.874722&lon=74.612222&APPID=3331e666239ea2e7435b26c22893307c"
        guard let url = URL(string: urlString ) else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let tWelcome = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    self.display(welcome: tWelcome)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func display(welcome:Welcome){
        city.text = welcome.name
        temperature.text = "\(Int(welcome.main.temp - 273.15)) °C"
        switch welcome.weather[0].main {
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
    }
}

