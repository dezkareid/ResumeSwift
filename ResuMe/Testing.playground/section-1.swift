// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var urlPath = "https://script.google.com/macros/s/AKfycbyx9FM2Athv6v0yuKzES1jZI7sCdqbY3mbtcnzrdnSblsmh0AQ/exec"
var url: NSURL = NSURL(string: urlPath)
var session = NSURLSession.sharedSession()
var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
    println("Task completed")
    if(error) {
        // If there is an error in the web request, print it to the console
        println(error.localizedDescription)
    }
    var err: NSError?
    var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
    if(err?) {
        // If there is an error parsing JSON, print it to the console
        println("JSON Error \(err!.localizedDescription)")
    }
    var results: NSArray = jsonResult["cursos"] as NSArray
    dispatch_async(dispatch_get_main_queue(), {
        println(results.count)
        })
    })
task.resume()