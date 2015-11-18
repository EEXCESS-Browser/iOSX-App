//
//  FavouriteTableViewController.swift
//  Browser
//
//  Created by Patrick Büttner on 01.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

protocol BackDelegate
{
    func receiveInfo(ctrl: FavouriteTableViewController, info: FavouritesModel)
}

class FavouriteTableViewController: UITableViewController
{
    var favourites = [FavouritesModel]()
    var fav = FavouritesModel()
    var delegate : BackDelegate? = nil
    var p = DataObjectPersistency()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favourites.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavouriteCell", forIndexPath: indexPath) as! FavouriteCell
        
        cell.lblTitle.text = "Titel: \(favourites[indexPath.row].title)"
        cell.lblUrl.text = "URL: \(favourites[indexPath.row].url)"
    
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(delegate != nil)
        {
            fav.url = favourites[indexPath.row].url
            favourites.append(fav)
            
            delegate!.receiveInfo(self, info: fav)
        }       
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            favourites.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            p.saveDataObject(favourites)
            
        }

    }
}
