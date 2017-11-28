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
var numberOfLinksPerPage = 10

class RedditLinksController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	@IBOutlet weak var tableView: UITableView?
	@IBOutlet weak var previousLinksButton: UIButton?
	@IBOutlet weak var nextLinksButton: UIButton?
	@IBOutlet weak var homeButton: UIButton?
	
	var currentPage: Int = 0
	{
		didSet
		{
			updateButtons()
			
			self.tableView?.reloadData()
		}
	}
	
	var redditLinks: Array<RedditLink>?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		tableView?.rowHeight = UITableViewAutomaticDimension
		tableView?.estimatedRowHeight = 171
		
		getLinksForCurrentPage()
		
		currentPage = 0
	}
	
	func updateButtons()
	{
		previousLinksButton?.isEnabled = !(0 == currentPage)
		let numberOfLinks = redditLinks?.count ?? 0
		nextLinksButton?.isEnabled = numberOfLinks > (currentPage + 1) * numberOfLinksPerPage
	}
	
	func getLinksForCurrentPage()
	{
		RedditPerformer().getTop()
		{ (receivedLinks, nil) in
			
			self.redditLinks = receivedLinks
			self.tableView?.reloadData()
			self.updateButtons()
		}
	}

	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let result: Int
		let numberOfLinks = redditLinks?.count ?? 0
		if (currentPage + 1) * numberOfLinksPerPage > numberOfLinks
		{
			result = numberOfLinks	 % numberOfLinksPerPage
		}
		else
		{
			result = numberOfLinksPerPage
		}
		return result;
	}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: RedditLinkCellID, for: indexPath) as! RedditLinkCell
		
		let index = indexPath.row + (currentPage * numberOfLinksPerPage)
		
		if let redditLinks = redditLinks, redditLinks.count > index
		{
			cell.redditLink = redditLinks[index]
		}
		
		return cell
	}
	
	// MARK: - IBActions
	
	@IBAction func showPrevious(sender: UIButton)
	{
		if currentPage > 0
		{
			currentPage -= 1
		}
	}
	
	@IBAction func showHome(sender: UIButton)
	{
		currentPage = 0
	}
	
	@IBAction func showNext(sender: UIButton)
	{
		currentPage += 1
	}

}

