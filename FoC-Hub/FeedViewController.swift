//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var title = "None"
var category = "None"
var idChosen = "None"


var titleList: [String] = []
var idList: [String] = []
var voteList: [String] = []
var colorList: [UIColor] = []

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let titleHeaders = ["Questions", "Tutorials", "Showcase"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(titleList.count)
        return titleList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = titleList[indexPath.row]
        cell.textLabel?.textColor = colorList[indexPath.row]
        cell.detailTextLabel?.text = ("Votes: \(voteList[indexPath.row])")
        //cell.contentView.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        
        
        //cell.textLabel?.text = "title"
        return cell
        
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categoryChosen.capitalizedString + "s"
    }
    
    @IBAction func fetchData(sender: AnyObject) {
        titleList = []
        voteList = []
        idList = []
        colorList = []
        
        let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?limit=50&type="+categoryChosen)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) in
            do {
                let jsonObject:NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                
                
                //print(jsonObject.count)
                print(jsonObject)
                var color: UIColor
                //Loops trough every item in jsonObject and saves title of each item in titleList
                for i in 0..<jsonObject.count {
                    let title = jsonObject[i]["title"] as! String
                    let vote = jsonObject[i]["votes"] as! String
                    let id = jsonObject[i]["id"] as! String
                    
                    
                    
                    if jsonObject[i]["type"] as? String == "question" {
                        color = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
                        
                    } else if jsonObject[i]["type"] as? String == "tutorial" {
                        color = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1)
                    
                    } else if jsonObject[i]["type"] as? String == "showcase" {
                        color = UIColor(red: 0.2, green: 0.4, blue: 1, alpha: 1)
                        
                    } else {
                    print("Cant find category")
                        color = UIColor.redColor()
                    }
                    
                    
                    
                    //print(title)
                    titleList.append(title)
                    voteList.append(vote)
                    idList.append(id)
                    colorList.append(color)
                }
                
                //print(titleList)
                self.tableView.reloadData()
                
                
                
            } catch {
               print(error)
            }
        })
        task?.resume()
        //print("Fetched data")
    }
    
    //HTTP Request
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(self)
        
    }
    
    
    @IBAction func refreshCellView(sender: AnyObject) {
        fetchData(self)
        self.tableView.reloadData()
        //print("Fetched data")
    }
    
    //Change viewcontroller
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(titleList[indexPath.row]) //CODE TO BE RUN ON CELL TOUCH
        
        //Changes color of text when cell is pressed
        //tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.greenColor()
        self.performSegueWithIdentifier("showDetails", sender: indexPath)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            let indexPath:NSIndexPath = sender as! NSIndexPath
            let detailViewController:DetailViewController = segue.destinationViewController as! DetailViewController
            //detailViewController.detailTitle = titleList[indexPath.row]
            detailViewController.postID = idList[indexPath.row]
        }
    }
}
