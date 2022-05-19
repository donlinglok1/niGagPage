//
//  ViewController.swift
//  nineGagPage
//
//  Created by KennethT on 5/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//

import UIKit
import PagingMenuController

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// go to the paging menu controller
		let pagingMenuController = self.childViewControllers.first as! PagingMenuController
		pagingMenuController.delegate = self
		pagingMenuController.setup(PagingMenuOptions())
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension ViewController: PagingMenuControllerDelegate {
	// MARK: - PagingMenuControllerDelegate

	func willMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
	}

	func didMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
	}

	func willMoveToMenuItemView(menuItemView: MenuItemView, previousMenuItemView: MenuItemView) {
	}

	func didMoveToMenuItemView(menuItemView: MenuItemView, previousMenuItemView: MenuItemView) {
	}
}
