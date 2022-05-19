//
//  Fresh.swift
//  nineGagPage
//
//  Created by KennethT on 7/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//
import UIKit

class Trending: PostsListController {
	// different page different source
	override var source1: String { get { return "http://test.darkdusk.org/9gag2json/trending.php" } }
	override var source2: String { get { return "http://test.darkdusk.org/9gag2json/wtf.php" } }

	// return the view and controller to mainControll
	class func instantiateFromStoryboard() -> Trending {
		return UIStoryboard(name: String(self), bundle: nil).instantiateViewControllerWithIdentifier(String(self)) as! Trending;
	}
}