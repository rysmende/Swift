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
    }

  
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func clearInputs(_ sender: Any) {
        taskTitle.text = ""
        taskDescription.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createCell" {
            let tableViewController = segue.destination as? TableViewController
            if taskTitle.text != "" && taskDescription.text != ""
            {
                tableViewController?.taskTitles.append(taskTitle.text!)
                tableViewController?.taskSubTitles.append(taskDescription.text!)
            }
        } else {
                print("shit happened")
                return
            }
       }
}
