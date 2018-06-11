//
//  FilterListViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class FilterListViewController: UIViewController {
    
    var filterListData = [FilterListTreeDataModel]()
    
    @IBOutlet weak var treeViewFilterList: CITreeView!
    
    @IBOutlet weak var buttonApply: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterListData = FilterListTreeDataModel.getDefaultCITreeViewData()
        
        //Set Datasource and Delegates
        self.treeViewFilterList.treeViewDelegate = self
        self.treeViewFilterList.treeViewDataSource = self
        self.treeViewFilterList.estimatedRowHeight = 50.0
        self.treeViewFilterList.collapseNoneSelectedRows = true
        
        //Register Cells
        self.treeViewFilterList.register(UINib.init(nibName: "FilterListTableViewCell_FirstLevel", bundle: nil), forCellReuseIdentifier: "FilterListTableViewCell_FirstLevel")
        self.treeViewFilterList.register(UINib.init(nibName: "FilterListTableViewCell_SecondLevel", bundle: nil), forCellReuseIdentifier: "FilterListTableViewCell_SecondLevel")
        
        //Set Border to Apply Button
        self.buttonApply.layer.borderColor = UIColor.white.cgColor
        self.buttonApply.layer.borderWidth = 0.5
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonApplyTapped(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
}

extension FilterListViewController : CITreeViewDelegate {
    
    func treeView(_ treeView: CITreeView, heightForRowAt indexPath: IndexPath, withTreeViewNode treeViewNode: CITreeViewNode) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func treeView(_ treeView: CITreeView, didSelectRowAt treeViewNode: CITreeViewNode) {
        
        if treeViewNode.level == 1 {
            
            //Child Item is Selected
            let filterListItem = treeViewNode.item as! FilterListTreeDataModel
            filterListItem.isSelected =  !filterListItem.isSelected
            
            //Reload table
            self.treeViewFilterList.reloadData()
        }
    }
    
    func willExpandTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {
    }
    
    func didExpandTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {
        self.treeViewFilterList.reloadData()
    }
    
    func willCollapseTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {
    }
    
    func didCollapseTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {
          self.treeViewFilterList.reloadData()
    }
}

extension FilterListViewController : CITreeViewDataSource {
    
    func treeView(_ treeView: CITreeView, atIndexPath indexPath: IndexPath, withTreeViewNode treeViewNode: CITreeViewNode) -> UITableViewCell {
        
        switch treeViewNode.level {
        case 0:
            let firstLevelCell: FilterListTableViewCell_FirstLevel = treeView.dequeueReusableCell(withIdentifier: "FilterListTableViewCell_FirstLevel") as! FilterListTableViewCell_FirstLevel
            firstLevelCell.setUpData(treeViewNode: treeViewNode)
            firstLevelCell.selectionStyle = .none
            return firstLevelCell
        case 1:
            let secondLevelCell: FilterListTableViewCell_SecondLevel = treeView.dequeueReusableCell(withIdentifier: "FilterListTableViewCell_SecondLevel") as! FilterListTableViewCell_SecondLevel
            secondLevelCell.setUpData(treeViewNode: treeViewNode)
            secondLevelCell.selectionStyle = .none
            return secondLevelCell
        default:
            return UITableViewCell()
        }
    }
    
    func treeViewSelectedNodeChildren(for treeViewNodeItem: Any) -> [Any] {
        if let dataObj = treeViewNodeItem as? FilterListTreeDataModel {
            return dataObj.children
        }
        return []
        
    }
    
    func treeViewDataArray() -> [Any] {
        return self.filterListData
    }
}

