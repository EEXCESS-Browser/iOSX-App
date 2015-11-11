//
//  OptionsController.swift
//  Browser
//
//  Created by Andreas Ziemer on 11.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class OptionsController: UITableViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let homeCell = tableView.dequeueReusableCellWithIdentifier("FavouriteCell", forIndexPath: indexPath) as! FavouriteCell
        
        homeCell.lblTitle.text = "Home"
        homeCell.lblUrl.text = "URL"
        
        return homeCell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
}