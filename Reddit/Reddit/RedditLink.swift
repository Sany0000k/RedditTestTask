//
//  RedditLink.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/27/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import Foundation

let titleKey = "title"
let authorKey = "author"
let entryDateKey = ""
let thumbnailKey = "thumbnail"
let numberOfCommentsKey = "num_comments"

class RedditLink
{
	let title: String?
	let author: String?
	let entryDate: NSDate?
	let thumbnail: String?
	let image: String?
	let numberOfComments: Int?

	init(json: Dictionary<String, Any>)
	{
		title = json[titleKey] as? String
		author = json[authorKey] as? String
		entryDate = json[entryDateKey] as? NSDate
		thumbnail = json[thumbnailKey] as? String
		
		numberOfComments = json[numberOfCommentsKey] as? Int
		
		if let imageURLs = (json as NSDictionary).value(forKeyPath: "preview.images.source.url") as? Array<String>
		{
			image = imageURLs[0]
		}
		else
		{
			image = nil
		}
	}
}
