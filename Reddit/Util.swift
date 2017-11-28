//
//  Util.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/29/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import Foundation
import UIKit

typealias ImagekGetterCompletion = (UIImage?, Error?) -> ()

class Util
{
	func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
	{
		URLSession.shared.dataTask(with: url)
		{ data, response, error in
			
			completion(data, response, error)
			}.resume()
	}
	
	func downloadImage(url: URL, completion: @escaping ImagekGetterCompletion)
	{
		getDataFromUrl(url: url)
		{ data, response, error in
			guard let data = data, error == nil else
			{
				completion(nil, error)
				return
			}
			print(response?.suggestedFilename ?? url.lastPathComponent)
			
			DispatchQueue.main.async()
			{
				completion(UIImage(data: data), nil)
			}
		}
	}
}
