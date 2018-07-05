//
//  ShippingDetailsViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 03/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import RSSelectionMenu
import LTHRadioButton

class ShippingDetailsViewController: UIViewController {
    
    @IBOutlet weak var radioButtonExistingAdd: LTHRadioButton!
    @IBOutlet weak var radioButtonNewAdd: LTHRadioButton!
    @IBOutlet weak var viewExistingAdd: UIView!
    @IBOutlet weak var constraintExistingAddHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewShippingDetailsHeader: UIView!
    @IBOutlet weak var textFieldShippingFirstName: UITextField!
    @IBOutlet weak var textFieldShippingLastName: UITextField!
    @IBOutlet weak var textFieldShippingCompany: UITextField!
    @IBOutlet weak var textFieldShippingAddress1: UITextField!
    @IBOutlet weak var textFieldShippingAddress2: UITextField!
    @IBOutlet weak var textFieldShippingCity: UITextField!
    @IBOutlet weak var textFieldShippingPostCode: UITextField!
    @IBOutlet weak var textFieldShippingCountry: UITextField!
    @IBOutlet weak var textFieldShippingRegionState: UITextField!
    @IBOutlet weak var constraintShippingDetailsHeight: NSLayoutConstraint!
    
    var shoudlDisplayShippingDetails = true
    var isExistingAddSelected = true
    var countryListArray: [Country]?
    var countryList: [String]?
    var stateList: [String]?
    
    var selectedState: String? {
        didSet {
            self.textFieldShippingRegionState.text = selectedState
        }
    }
    
    var selectedCountry: String? {
        didSet {
            
            self.textFieldShippingCountry.text = selectedCountry
            self.stateList = self.countryListArray?.filter({ (country) -> Bool in
                return country.country == selectedCountry
            }).first?.states
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryListArray = AppInstances.appDelegate.getCountryListMappingModel()?.countries
        self.countryList = countryListArray?.compactMap({ (country) -> String? in
            return country.country
        })
        
        self.displayShippingDetails(shouldDisplay: self.shoudlDisplayShippingDetails)
        
        //Set Up Radio Button
        self.setUpRadioButtonsUI()
        self.setUpRadioButtonsState()
        
        self.viewExistingAdd.addDropShadow()
        self.viewShippingDetailsHeader.addDropShadow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpRadioButtonsUI() {
        self.radioButtonExistingAdd.selectedColor = UIColor.orange
        self.radioButtonExistingAdd.deselectedColor = UIColor.orange
        self.radioButtonNewAdd.selectedColor = UIColor.orange
        self.radioButtonNewAdd.deselectedColor = UIColor.orange
        
        //Radio Button Actions
        self.radioButtonExistingAdd.onSelect {
            self.isExistingAddSelected = true
            self.setUpRadioButtonsState()
        }
        
        self.radioButtonNewAdd.onSelect {
            self.isExistingAddSelected = false
            self.setUpRadioButtonsState()
        }
    }
    
    private func setUpRadioButtonsState() {
        if self.isExistingAddSelected {
            self.radioButtonExistingAdd.select(animated: true)
            self.radioButtonNewAdd.deselect(animated: true)
            self.displayShippingDetails(shouldDisplay: false)
        } else {
            self.radioButtonExistingAdd.deselect(animated: true)
            self.radioButtonNewAdd.select(animated: true)
            self.displayShippingDetails(shouldDisplay: true)
        }
    }
    
    private func displayShippingDetails(shouldDisplay: Bool) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.constraintShippingDetailsHeight.constant = shouldDisplay ? 621: 0
            self.constraintExistingAddHeight.constant = shouldDisplay ? 0: 100
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    // MARK: -
    
    @IBAction func buttonContinueTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "DeliveryMethodViewController", sender: nil)
    }
    
    @IBAction func buttonShippingDetailsHeaderTapped(_ sender: Any) {
        self.shoudlDisplayShippingDetails = !self.shoudlDisplayShippingDetails
        self.displayShippingDetails(shouldDisplay: self.shoudlDisplayShippingDetails)
    }
    
    @IBAction func buttonShippingRegionStateTapped(_ sender: Any) {
        
        if let stateListArray = self.stateList {
            
            let stateSelectionMenu =  RSSelectionMenu(dataSource: stateListArray) { (cell, object, indexPath) in
                cell.textLabel?.text = object
            }
            
            var selectedItemsArr = [String]()
            if let selectedItem = self.selectedState {
                selectedItemsArr.append(selectedItem)
            }
            
            stateSelectionMenu.setSelectedItems(items: selectedItemsArr) { (text, isSelected, selectedItems) in
                self.selectedState = selectedItems.first
            }
            
            stateSelectionMenu.showSearchBar { (searchtext) -> ([String]) in
                return stateListArray.filter({ $0.lowercased().hasPrefix(searchtext.lowercased()) })
            }
            stateSelectionMenu.show(style: .Formsheet, from: self)
        }
    }
    
    @IBAction func buttonShippingCountryTapped(_ sender: Any) {
        
        if let countryListArray = self.countryList {
            
            let countrySelectionMenu =  RSSelectionMenu(dataSource: countryListArray) { (cell, object, indexPath) in
                cell.textLabel?.text = object
            }
            
            var selectedItemsArr = [String]()
            if let selectedItem = self.selectedCountry {
                selectedItemsArr.append(selectedItem)
            }
            
            countrySelectionMenu.setSelectedItems(items: selectedItemsArr) { (text, isSelected, selectedItems) in
                self.selectedCountry = selectedItems.first
            }
            
            countrySelectionMenu.showSearchBar { (searchtext) -> ([String]) in
                return countryListArray.filter({ $0.lowercased().hasPrefix(searchtext.lowercased()) })
            }
            countrySelectionMenu.show(style: .Formsheet, from: self)
        }
    }
}
