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
	func getTop(limit: UInt = 100,  completion: @escaping RedditLinkGetterCompletion)
	{
		let completionOnMainThread: RedditLinkGetterCompletion =
		{ (arrayOfLinks, error) -> () in
			
			DispatchQueue.main.async()
			{
				completion(arrayOfLinks, error)
			}
			
		}
		
		DispatchQueue.global(qos: .userInitiated).async
		{
			let url = URL(string: "https://reddit.com/r/ios/top.json?limit=\(limit)")!
			let session = URLSession.shared
			let task = session.dataTask(with: url)
			{ data, response, error in
				
				guard let data = data, error == nil else
				{
					completionOnMainThread(nil, error)
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
							
							completionOnMainThread(result, nil)
						}
					}
				}
				catch let jsonParseError
				{
					completionOnMainThread(nil, jsonParseError)
				}
			}
			
			task.resume()
		}
	}
}
