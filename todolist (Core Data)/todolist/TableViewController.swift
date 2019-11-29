//
//  TableViewController.swift
//  todolist
//
//  Created by ITLabAdmin on 10/21/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit
let defaults = UserDefaults.standard

class TableViewController: UITableViewController, TaskDelegate{
    func save(title: String, description: String, index: Int) {
        <#code#>
    }
    
    var taskTitles = ["First task"]
    var taskSubTitles = ["First description"]
    var dones = [true]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  taskTitles.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTitle", for: indexPath)
        cell.textLabel?.text = taskTitles[indexPath.row]
        cell.detailTextLabel?.text = taskSubTitles[indexPath.row]
        if (dones[indexPath.row]){
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskTitles.remove(at: indexPath.row)
            taskSubTitles.remove(at: indexPath.row)
            dones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoViewController = storyboard.instantiateViewController(withIdentifier: "infoVC") as! InfoViewController
        infoViewController.delegate = self
        let index = indexPath.row
        infoViewController.taskTitle = taskTitles[index]
        infoViewController.taskSubTitle = taskSubTitles[index]
        infoViewController.index = index
        present(infoViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (dones[indexPath.row]){
            dones[indexPath.row] = false
        } else {
            dones[indexPath.row] = true
        }
        tableView.reloadData()
    }
    func saveData(title:String, description:String, index:Int)
    {
         let vc = InfoViewController(nibName: "InfoViewController", bundle: nil)
        vc.tableViewController = self
        taskTitles[index] = title
        taskSubTitles[index] = description
    }
    
}
