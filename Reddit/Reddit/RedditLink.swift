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
let imageKey = ""
let numberOfCommentsKey = "num_comments"

class RedditLink
{
	let title: String?
	let author: String?
	let entryDate: NSDate?
	let thumbnail: NSString?
	let image: NSString?
	let numberOfComments: Int?

	init(json: Dictionary<String, Any>)
	{
		title = json[titleKey] as? String
		author = json[authorKey] as? String
		entryDate = json[entryDateKey] as? NSDate
		thumbnail = json[thumbnailKey] as? NSString
		image = json[imageKey] as? NSString
		numberOfComments = json[numberOfCommentsKey] as? Int
	}
}
