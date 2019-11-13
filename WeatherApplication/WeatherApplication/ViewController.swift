//
//  ViewController.swift
//  WeatherApplication
//
//  Created by ITLabAdmin on 11/13/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit
struct FlickerJSON{
    let code : String
    let message: Int
    let cnt : Int
    struct item {
        let dt:CLong
    struct main {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int
        let grnd_level: Int
        let humidity: Int
        let temp_kf: Double
    }
    struct weatherItem {
        let id: Int
        let main: String
        let description: String
        let icon: String
        }
        let weather:[weatherItem]
    struct  clouds {
            let all: Int
        }
    struct wind {
            let speed: Int
            let deg: Int
        }
    struct sys{
            let pod: String
        }
    let dt_txt: String
    }
    let list: [item]
    struct city {
        let id:CLong
        let name:String
        struct coord {
        let lat:Double
            let lon: Double
        }
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: CLong
        let sunset: CLong
    }
}

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3") else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {
                return
            }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            
        }.resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

