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
