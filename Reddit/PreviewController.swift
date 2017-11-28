//
//  PreviewController.swift
//  Reddit
//
//  Created by Alexander Chulanov on 11/29/17.
//  Copyright © 2017 Alexander Chulanov. All rights reserved.
//

import Foundation
import UIKit

class PreviewController: UIViewController
{
	@IBOutlet weak var imageView: UIImageView?
	var downloadedImage: UIImage?
	
	var redditLink: RedditLink!
	{
		didSet
		{
			if let imageURLString = redditLink?.image, let imageURL = URL(string: imageURLString)
			{
				Util().downloadImage(url: imageURL)
				{ (image, nil) in
					
					self.downloadedImage = image
					self.imageView?.image = image
				}
			}
		}
	}
}
