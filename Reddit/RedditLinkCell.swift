//
//  RedditLinkCell.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/28/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import Foundation
import UIKit

class RedditLinkCell: UITableViewCell
{
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var authorLabel: UILabel?
	@IBOutlet weak var entryDateLabel: UILabel?
	@IBOutlet weak var thumbnailImageView: UIImageView?
	@IBOutlet weak var numberOfCommentsLabel: UILabel?
	
	var redditLink: RedditLink?
	{
		didSet
		{
			titleLabel?.text = redditLink?.title
			authorLabel?.text = redditLink?.author
			
			thumbnailImageView?.image = nil
			
			if let thumbnailURLString = redditLink?.thumbnail, let thumbnailURL = URL(string: thumbnailURLString)
			{
				downloadImage(url: thumbnailURL)
			}
			
			let numberOfComments = redditLink?.numberOfComments ?? 0
			numberOfCommentsLabel?.text = "#\(numberOfComments)"
		}
	}
	
	func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
	{
		URLSession.shared.dataTask(with: url)
		{ data, response, error in
			
			completion(data, response, error)
		}.resume()
	}
	
	func downloadImage(url: URL)
	{
		getDataFromUrl(url: url)
		{ data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			
			DispatchQueue.main.async()
			{
				self.thumbnailImageView?.image = UIImage(data: data)
			}
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		redditLink = nil
	}
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		redditLink = nil
	}
}
