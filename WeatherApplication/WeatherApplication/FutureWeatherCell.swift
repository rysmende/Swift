//
//  FutureWeatherCell.swift
//  WeatherApplication
//
//  Created by ITLabAdmin on 11/20/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit

class FutureWeatherCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
