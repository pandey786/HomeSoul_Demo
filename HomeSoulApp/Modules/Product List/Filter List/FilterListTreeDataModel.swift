//
//  FilterListTreeDataModel.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 16/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import Foundation
import UIKit

class FilterListTreeDataModel {
    
    let name : String
    var isSelected = false
    var children : [FilterListTreeDataModel]
    
    init(name : String, children: [FilterListTreeDataModel]) {
        self.name = name
        self.children = children
    }
    
    convenience init(name : String) {
        self.init(name: name, children: [FilterListTreeDataModel]())
    }
    
    func addChild(_ child : FilterListTreeDataModel) {
        self.children.append(child)
    }
    
    func removeChild(_ child : FilterListTreeDataModel) {
        self.children = self.children.filter( {$0 !== child})
    }
}

extension FilterListTreeDataModel {
    
    static func getDefaultCITreeViewData() -> [FilterListTreeDataModel] {
        

        let child11 = FilterListTreeDataModel(name: "BELOW 500")
        let child12 = FilterListTreeDataModel(name: "500-1000")
        let child13 = FilterListTreeDataModel(name: "1001-1500")
        let parent1 = FilterListTreeDataModel(name: "COLLECTIONS BEST PRICE", children: [child11, child12, child13])
        
        let child21 = FilterListTreeDataModel(name: "WHITE")
        let child22 = FilterListTreeDataModel(name: "BEIGE")
        let child23 = FilterListTreeDataModel(name: "YELLOW")
        let child24 = FilterListTreeDataModel(name: "ORANGE")
        let child25 = FilterListTreeDataModel(name: "BROWN")
        let parent2 = FilterListTreeDataModel(name: "COLOURS", children: [child21, child22, child23, child24, child25])
        
        let child31 = FilterListTreeDataModel(name: "PAISLEY")
        let child32 = FilterListTreeDataModel(name: "LEAVES")
        let child33 = FilterListTreeDataModel(name: "SCROLL")
        let parent3 = FilterListTreeDataModel(name: "DESIGN", children: [child31, child32,child33])
        
        return [parent1, parent2, parent3]
    }
    
    
}
