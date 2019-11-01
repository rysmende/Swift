//
//  AddeViewController.swift
//  todolist
//
//  Created by ITLabAdmin on 10/21/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit

class AddeViewController: UIViewController {

    var tTitle: String = ""
    var tDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func create(_ sender: Any) {
        if taskTitle.text != "" && taskDescription.text != ""{
            taskTitles.append(taskTitle.text!)
            taskSubTitles.append(taskDescription.text!)
            dones.append(false)
            defaults.set(taskTitles, forKey: "taskTitles")
            defaults.set(taskSubTitles, forKey: "taskSubTitles")
            defaults.set(dones, forKey: "dones")
        }
    }
    
    
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
