//
//  RedditPerformer.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/27/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import Foundation

typealias RedditLinkGetterCompletion = ([RedditLink]?, Error?) -> ()

class RedditPerformer
{
	func getTop(fromNumber: UInt = 0, limit: UInt = 25,  completion: @escaping RedditLinkGetterCompletion)
	{
		let url = URL(string: "https://reddit.com/r/ios/top.json?limit=\(limit)&count=\(fromNumber)")!
		let session = URLSession.shared
		let task = session.dataTask(with: url)
		{ data, response, error in
			guard let data = data, error == nil else
			{
				completion(nil, error)
				return
			}
			
			do
			{
				if let jsonObj = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String : Any]
				{
					if let childrenJson = (jsonObj as NSDictionary).value(forKeyPath: "data.children.data") as? [[String: Any]]
					{
						let result = childrenJson.map(
						{(json) -> RedditLink in
							return RedditLink(json: json)
						})
						
						completion(result, nil)
					}
				}
			}
			catch let jsonParseError
			{
				completion(nil, jsonParseError)
			}
		}
		
		task.resume()
	}
}
