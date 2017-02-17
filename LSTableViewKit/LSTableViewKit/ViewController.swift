//
//  ViewController.swift
//  LSTableViewKit
//
//  Created by 刘双 on 2017/2/17.
//  Copyright © 2017年 刘双. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate{
    let kit = LSTableViewKit(tableView: UITableView(frame: UIScreen.main.bounds, style: .grouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       kit.registerCell(cellClass: LSBaseCell.self)
    
       let cellModel = LSCellItem()
       cellModel.model = "1"
       cellModel.cellClass = "LSBaseCell"
       kit.addCellDatas(datas: ["11111","2222","3333","4444","5555","6666"])
        
       kit.tableView.delegate = self
       kit.addToviewController(viewController: self)
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

