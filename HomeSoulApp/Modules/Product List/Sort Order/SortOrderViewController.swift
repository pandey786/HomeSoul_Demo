//
//  SortOrderViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class SortOrderViewController: UIViewController {

    var sortOderArray = ["LATEST", "POPULARITY", "PRICE(HIGH TO LOW)", "PRICE(LOW TO HIGH)"]
    var selectedIndex: Int?
    
     @IBOutlet weak var tableViewSortOrder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set Dynamic height
        self.tableViewSortOrder.estimatedRowHeight = 50.0
        self.tableViewSortOrder.rowHeight = UITableViewAutomaticDimension
        
        //Register Cell
        self.tableViewSortOrder.register(UINib.init(nibName: "SortOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "SortOrderTableViewCell")
    }

    @IBAction func buttonCloseTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension SortOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortOderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sortOrderCell: SortOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SortOrderTableViewCell") as! SortOrderTableViewCell
        
        //Set Up Cell
        sortOrderCell.labelTitle.text = self.sortOderArray[indexPath.row]
        if self.selectedIndex != nil && indexPath.row == self.selectedIndex {
            sortOrderCell.labelTitle.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
            sortOrderCell.viewUnderLine.isHidden = false
        } else {
            sortOrderCell.labelTitle.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
            sortOrderCell.viewUnderLine.isHidden = true
        }
        
        sortOrderCell.selectionStyle = .none
        return sortOrderCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.tableViewSortOrder.reloadData()
    }
    
}
