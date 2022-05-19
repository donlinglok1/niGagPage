//
//  Fresh.swift
//  nineGagPage
//
//  Created by KennethT on 7/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//
import UIKit

class Fresh: PostsListController {
	// different page different source
	override var source1: String { get { return "http://test.darkdusk.org/9gag2json/fresh.php" } }
	override var source2: String { get { return "http://test.darkdusk.org/9gag2json/funny.php" } }

	// return the view and controller to mainControll
	class func instantiateFromStoryboard() -> Fresh {
		return UIStoryboard(name: String(self), bundle: nil).instantiateViewControllerWithIdentifier(String(self)) as! Fresh;
	}
}