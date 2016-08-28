//
//  ViewController.swift
//  FrameRateDemo
//
//  Created by dimsky on 16/8/28.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var isStart = false
    var data: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "ComplexCell", bundle: nil), forCellReuseIdentifier: "ComplexCell")
        print(UIApplication.sharedApplication().windows)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ComplexCell") as! ComplexCell
        cell.image1 = UIImage(named: "aaa")
        cell.image2 = UIImage(named: "aaa")
        cell.image3 = UIImage(named: "aaa")
        cell.image4 = UIImage(named: "aaa")
        return cell
    }


    @IBAction func AddAction(sender: AnyObject) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

