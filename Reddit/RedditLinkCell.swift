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
			let author = redditLink?.author ?? ""
			authorLabel?.text = "author: \(author)"
			
			thumbnailImageView?.image = nil
			
			if let thumbnailURLString = redditLink?.thumbnail, let thumbnailURL = URL(string: thumbnailURLString)
			{
				Util().downloadImage(url: thumbnailURL)
				{ (image, nil) in
					self.thumbnailImageView?.image = image
				}
			}
			
			let numberOfComments = redditLink?.numberOfComments ?? 0
			numberOfCommentsLabel?.text = "#\(numberOfComments)"
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
