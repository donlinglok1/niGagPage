//
//  Http.swift
//  nineGagPage
//
//  Created by KennethT on 7/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//

import SwiftHTTP

// util of http function
func httpget(ui: UIViewController, url: String, callback: ((data: [[String: AnyObject]]) -> Void)!) {
	do {
		let opt = try HTTP.GET(url);
		opt.start { response in
			if let err = response.error {
				print("error: \(err.localizedDescription)");
			}

			print("opt finished: \(response.description)");

			let result = try? NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as! [[String: AnyObject]];
			callback(data: result!);
		}
	} catch let error {
		print("got an error creating the request: \(error)");
		callback(data: []);
	}
}

// TODO post,put,delete..