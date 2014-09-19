//
//  CoursesControllerTableViewController.swift
//  ResuMe
//
//  Created by Joel Humberto Gómez Paredes on 04/08/14.
//  Copyright (c) 2014 Joel Humberto Gómez Paredes. All rights reserved.
//

import UIKit

class CoursesControllerTableViewController: UITableViewController {

    var courses : NSArray = [];
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlPath = "https://script.google.com/macros/s/AKfycbyx9FM2Athv6v0yuKzES1jZI7sCdqbY3mbtcnzrdnSblsmh0AQ/exec"
        var url: NSURL = NSURL(string: urlPath)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if((error) != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if((err?) != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            self.courses = jsonResult["cursos"] as NSArray
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                })
            
            })
        task.resume()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.courses.count
    }

    
  override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell{
        let cell = tableView?.dequeueReusableCellWithIdentifier("course", forIndexPath: indexPath!) as UITableViewCell as UITableViewCell

        // Configure the cell...
        var course = self.courses[indexPath!.row] as NSDictionary
        println(course["escuela"])
        cell.textLabel?.text = course["curso"] as? String
        
        cell.detailTextLabel?.text = course["escuela"] as? String

        var imgURL: NSURL = NSURL(string: course["imagen"] as String)
        
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            if !(error? != nil) {
                var image:UIImage = UIImage(data: data)
                
                               if let cellToUpdate = tableView?.cellForRowAtIndexPath(indexPath!) {
                    cellToUpdate.imageView?.image = image
                }
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
            })
        
        
        cell.imageView?.image = UIImage(named:"me.jpg")
        return cell
    }
    
    override func preferredStatusBarStyle()->UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
