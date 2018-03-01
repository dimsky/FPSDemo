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
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.register(UINib(nibName: "ComplexCell", bundle: nil), forCellReuseIdentifier: "ComplexCell")
        print(UIApplication.shared.windows)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplexCell") as! ComplexCell
        cell.image1 = UIImage(named: "aaa")
        cell.image2 = UIImage(named: "aaa")
        cell.image3 = UIImage(named: "aaa")
        cell.image4 = UIImage(named: "aaa")
        return cell
    }


    @IBAction func AddAction(sender: AnyObject) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

