//
//  ViewController.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/27/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import UIKit

var RedditLinkCellID = "RedditLinkCellID"
var estimatedRowHeight = 171

class RedditLinksController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	@IBOutlet weak var tableView: UITableView?
	@IBOutlet weak var previousLinksButton: UIButton?
	@IBOutlet weak var nextLinksButton: UIButton?
	@IBOutlet weak var homeButton: UIButton?
	
	var redditLinks: Array<RedditLink>?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		tableView?.rowHeight = UITableViewAutomaticDimension
		tableView?.estimatedRowHeight = 171
		
		RedditPerformer().getTop(fromNumber: 0, limit: 20)
		{ (receivedLinks, nil) in
			
			self.redditLinks = receivedLinks
			self.tableView?.reloadData()
		}
	}

	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return redditLinks?.count ?? 0;
	}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: RedditLinkCellID, for: indexPath) as! RedditLinkCell
		
		if let redditLinks = redditLinks
		{
			cell.redditLink = redditLinks[indexPath.row]
		}
		
		return cell
	}


}

