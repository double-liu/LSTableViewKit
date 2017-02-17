//
//  LSTableViewKit.swift
//  LSTableViewKit
//
//  Created by 刘双 on 2017/2/17.
//  Copyright © 2017年 刘双. All rights reserved.
//  数据管理  上下拉刷新

import UIKit

//MARK: -
public enum LSTableViewType {
    case group1Row1              //一组 一种
    case groupNRow1              //多组 一种
    case group1RowN              //一组 多种
    case groupNRowN              //多组 一种
}

class LSTableViewKit:NSObject,UITableViewDataSource{
   

     var tableView = UITableView()
     var sections  = [LSSectionItem]()
     var cellClass = [AnyClass]()
     var type:LSTableViewType = .group1Row1
    
    
     weak  var viewController:UIViewController?
    
     //MARK: - 构造方法
     convenience init(tableView:UITableView) {
        self.init()
        self.tableView = tableView
        tableView.dataSource = self

     }
    
    //MARK: - 注册Cell
    func registerCells(cellClass:[AnyClass]) {
        cellClass.forEach { (i) in
            self.registerCell(cellClass: i)
        }
        
    }
    func registerCell(cellClass:AnyClass) {
        tableView.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
        self.cellClass.append(cellClass)

    }
    
    
    //MARK: - 添加数据
    func addSectionItem(sectionItem:LSSectionItem){
       sections.append(sectionItem)
    }
    
    func addSectionItems(sectionItems:[LSSectionItem]){
        sectionItems.forEach { (item) in
            sections.append(item)
        }
    }
    //添加一组的数据源
    func addCellItems(cellItems:[LSCellItem]){
       let section = LSSectionItem(cellItem: cellItems)
       sections.append(section)
    }
    
    //添加一种Cell的数据源
    func addCellDatas(datas:[Any]) {
        if self.type == .group1Row1{
            let items = datas.map { (item) -> LSCellItem in
                return  LSCellItem(model: item, cellClass: String(describing: cellClass[0]))
            }
            self.addCellItems(cellItems: items)
        }else if self.type == .groupNRow1{
            let items = datas.map { (item) -> LSSectionItem in
                let section = LSSectionItem()
                section.cellItem = [LSCellItem(model: item, cellClass: String(describing: cellClass[0]))]
                return section
            }
            self.addSectionItems(sectionItems: items)
        }else{
        }
    }
    
    //
    func itemForCell(indexPath: IndexPath) -> LSCellItem {
       return  self.sections[indexPath.section].cellItem[indexPath.row]
    }
    
    //MARK: -
    func addToviewController(viewController:UIViewController) {
        self.viewController = viewController
        viewController.view.addSubview(tableView)
        tableView.frame = viewController.view.bounds
    }
    
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let model = sections[indexPath.section].cellItem[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: model.cellClass, for: indexPath) as! LSBaseCell
        cell.cellRefreshData(model, indexPath: indexPath)
        guard let vc = self.viewController          else {return cell}
        cell.viewController = vc
        return  cell
    }
}


//MARK: - Model
public class  LSCellItem{
    var cellClass = "LSBaseCell"
    var model:Any?
    convenience init(model:Any,cellClass:String){
       self.init()
        self.model = model
        self.cellClass = cellClass
    }
    
}

public class  LSSectionItem{
    var cellItem = [LSCellItem]()
    var headerItem:LSHeaderItem?
    var footerItem:LSHeaderItem?
    
    convenience init(cellItem:[LSCellItem]) {
        self.init()
        self.cellItem = cellItem
    }
}

public class  LSHeaderItem{
    
}

//MARK: - View
class  LSBaseCell:UITableViewCell{
    weak  var viewController:UIViewController?
    // 初始化方法
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cellRefreshData(_ data:LSCellItem,indexPath:IndexPath){
        if let model = data.model as? String {
            self.textLabel?.text = model
        }
    }
    
    public  class func heightForCell(_ data:LSCellItem,indexPath:IndexPath) -> CGFloat{
        return 44;
    }
}


//MARK: - UITableViewCell.extension
extension UITableViewCell{
    /**
     Cell刷新数据
     - parameter data: 数据源
     */
//    public func cellRefreshData(_ data:LSCellItem,indexPath:IndexPath){
//        
//    }
//    
//    public func cellRefreshData1(_ data:Any){
//        
//    }
//    
//    /**
//     计算Cell的高度
//     - parameter data: 数据源
//     - returns: 高度
//     */
//    public  class func heightForCell(_ data:LSCellItem,indexPath:IndexPath) -> CGFloat{
//        return 44;
//    }
    
}











