//
//  TableViewController.swift
//  todolist
//
//  Created by ITLabAdmin on 10/21/19.
//  Copyright © 2019 ITLabAdmin. All rights reserved.
//

import UIKit
let defaults = UserDefaults.standard
var taskTitles = [String]()
var taskSubTitles = [String]()
var dones = [Bool]()
var indexAt = 0

class TableViewController: UITableViewController {
    var searched = [String]()
    var searching = false
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        taskTitles = defaults.stringArray(forKey: "taskTitles") ?? [String]()
        taskSubTitles = defaults.stringArray(forKey: "taskSubTitles") ?? [String]()
        dones = defaults.array(forKey: "dones") as! [Bool]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sideMenus(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
         view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searching {
            return searched.count
        } else {
            return  taskTitles.count
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTitle", for: indexPath)
        if searching{
            cell.textLabel?.text = searched[indexPath.row]
            cell.detailTextLabel?.text = taskSubTitles[indexPath.row]
            if (dones[indexPath.row]){
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .white
            }
        } else {
        cell.textLabel?.text = taskTitles[indexPath.row]
        cell.detailTextLabel?.text = taskSubTitles[indexPath.row]
        if (dones[indexPath.row]){
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .white
            }
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            taskTitles.remove(at: indexPath.row)
            taskSubTitles.remove(at: indexPath.row)
            dones.remove(at: indexPath.row)
            defaults.set(taskTitles, forKey: "taskTitles")
            defaults.set(taskSubTitles, forKey: "taskSubTitles")
            defaults.set(dones, forKey: "dones")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        indexAt = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "infoVC") as UIViewController
        present(secondViewController, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (dones[indexPath.row]){
            dones[indexPath.row] = false
        } else {
            dones[indexPath.row] = true
        }
        defaults.set(dones, forKey: "dones")
        tableView.reloadData()
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension TableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = taskTitles.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        print ("searching")
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        print ("cancel")
        tableView.reloadData()
    }
}
