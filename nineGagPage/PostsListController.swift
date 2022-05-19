//
//  HotPostsViewController.swift
//  nineGagPage
//
//  Created by KennethT on 7/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//
import UIKit
import SDWebImage

class PostsListController: UITableViewController {
	// ----if design layout or api upgrade, only need to change the below code.----

	// two api json data soruce for two type of views
	var source1: String { get { return "http://test.darkdusk.org/9gag2json/hot.php" } }
	var source2: String { get { return "http://test.darkdusk.org/9gag2json/girl.php" } }

	// reload view on async
	func tableReload(tableView: UITableView) {
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			tableView.reloadData();
		})
	}

	// deal with data and tableview
	func initTableCell(index: Int, data: [[String: AnyObject]], cell: TableViewCell) {
		cell.label?.text = data[index]["title"] as? String;// set text
		cell.iView?.sd_setImageWithURL(NSURL(string: data[index]["img"] as! String),
			placeholderImage: UIImage(named: "load.png"));// set image with cache
	}

	// deal with data and collectView
	func initCollectionCell(index: Int, data: [[String: AnyObject]], cell: CollectionViewCell, callback: (() -> Void)!) {
		cell.label.text = data[index]["title"] as? String;// set text
		cell.imageView.sd_setImageWithURL(NSURL(string: data[index]["img"] as! String), placeholderImage: UIImage(named: "load.png"));
		// load image

		if (index >= data.count - 2) { // run on the scroll position near end
			callback();
		}
	}

	// ----if design layout or api upgrade, only need to change the above code.----

	// onload...
	override func viewDidLoad() {
		super.viewDidLoad();
		getTableData();// fetch posts json data
	}

	// double thread for two data source action
	var tableLoadCount = 0;// count of load more
	var tableDataLoading = false;// not loading till last request finished
	var tableData = [[String: AnyObject]]();// temp of json array data
	var tableDataEnd = false;// if no more new data, stop request in this lifecycle
	func getTableData() {
		if (!tableDataLoading && !tableDataEnd) {
			tableDataLoading = true;
			tableLoadCount = tableLoadCount + 1;

			httpget(self, url: "\(source1)?count=\(tableLoadCount)", callback: { (data) in
				if (self.tableData.count == data.count) {
					self.tableDataEnd = true;
					self.tableData[self.tableData.count - 1] = ["title": "Sorry This is the end", "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/9GAG_new_logo.svg/2000px-9GAG_new_logo.svg.png"];
					// replace the end of the array from loading to finish
				} else {
					self.tableData = data;// store json array for table view reload
				}

				self.tableReload(self.tableView);// reload
				self.tableDataLoading = false;
			})
		}
	}

	// same as getTableData but as the end reload the collection view
	var collectionLoadCount = 0;
	var collectionDataLoading = false;
	var collectionData = [[String: AnyObject]]();
	var collectionDataEnd = false;
	func intConllectionView(tableViewCell: TableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		if (!collectionDataLoading && !collectionDataEnd) {
			collectionDataLoading = true;
			collectionLoadCount = collectionLoadCount + 1;

			httpget(self, url: "\(source2)?count=\(collectionLoadCount)", callback: { (data) in
				if (self.collectionData.count == data.count) {
					self.collectionDataEnd = true;
					self.collectionData[self.collectionData.count - 1] = ["title": "Sorry This is the end", "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/9GAG_new_logo.svg/2000px-9GAG_new_logo.svg.png"];
				} else {
					self.collectionData = data;
				}

				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row);
					// reload the collection view by setting datasource
				})
				self.collectionDataLoading = false;
			})
		}
	}

	// tabview default function to decide size
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableData.count;
	}

	// init cell form data
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell;
		// load as custom cell view with image and text design and setting of collection view

		let index = indexPath.row;// the list position

		// init cell on Reuse.swift
		initTableCell(index, data: tableData, cell: cell);

		if (index == 0 && collectionLoadCount == 0) { // only run on first start
			intConllectionView((cell as TableViewCell), forRowAtIndexPath: indexPath);// inin the header collection
		} else if (index >= tableData.count - 2) { // if near bottom then load more
			getTableData();
		}

		return cell;
	}

}

extension PostsListController: UICollectionViewDelegate, UICollectionViewDataSource {
	// same as getHotData but as the end reload the collection view
	func getGirlData(collectionView: UICollectionView) {
		if (!collectionDataLoading && !collectionDataEnd) {
			collectionDataLoading = true;
			collectionLoadCount = collectionLoadCount + 1;

			httpget(self, url: "\(source2)?count=\(collectionLoadCount)", callback: { (data) in
				if (self.collectionData.count == data.count) {
					self.collectionDataEnd = true;
					self.collectionData[self.collectionData.count - 1] = ["title": "Sorry This is the end", "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/9GAG_new_logo.svg/2000px-9GAG_new_logo.svg.png"];
				} else {
					self.collectionData = data;
				}

				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					collectionView.reloadData();// reload collection view
					self.tableReload(self.tableView);// reload table view (parents of collection view)
					self.collectionDataLoading = false;
				})
			})
		}
	}

	// collection view default function to decide size
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionData.count;
	}

	// init collection cell from data
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell;
		// load as custom collection view with image and text design.

		// init cell on Reuse.swift
		initCollectionCell(indexPath.row, data: collectionData, cell: cell, callback: {
			self.getGirlData(collectionView);// load more data
		})

		return cell;
	}

}
