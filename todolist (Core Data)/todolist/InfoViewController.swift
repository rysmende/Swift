//
//  InfoViewController.swift
//  todolist
//
//  Created by ITLabAdmin on 10/22/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//
protocol TaskDelegate{
    func save(title: String, description: String, index: Int)
}
import UIKit

class InfoViewController: UIViewController {
    
    let delegate : TaskDelegate?
    @IBOutlet weak var tTitle: UITextField!
    @IBOutlet weak var tDescription: UITextField!
    var tableViewController: TableViewController?
    var taskTitle = ""
    var taskSubTitle = ""
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tTitle.text = taskTitle
        tDescription.text = taskSubTitle
        taskTitle = ""
        taskSubTitle = ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        tTitle.text = ""
        tDescription.text = ""
    }
    @IBAction func save(_ sender: Any) {
        if tTitle.text != "" && tDescription.text != "" && delegate != nil
        {
            delegate?.save(title: tTitle.text!, description: tDescription.text!, index: index)
        }
        
    }
}
