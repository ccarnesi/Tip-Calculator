//
//  TipCalculatorViewController.swift
//  TipCalc
//
//  Created by Chris Carnesi on 10/27/18.
//  Copyright © 2018 Carnesi. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        amountBeforeTaxTextField.becomeFirstResponder()
    }
    @IBOutlet weak var amountBeforeTaxTextField: UITextField!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var totalResultLabel: UILabel!
    @IBOutlet weak var eachPersonAmount: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    
    
    var tipCalculator = TipCalculator(amountBeforeTax: 0, tipPercentage: 0.10)
    func calculateBill(){
        tipCalculator.tipPercentage = Double(tipPercentageSlider.value)/100
        tipCalculator.amountBeforeTax = (amountBeforeTaxTextField.text! as NSString).doubleValue
        tipCalculator.calculateTip()
        updateUI()
    }
    func updateUI(){
        totalResultLabel.text = String(format: "$%0.2f", tipCalculator.totalAmount)
        totalResultLabel.sizeToFit()
        let numberOfPeople: Int = Int(numberOfPeopleSlider.value)
        eachPersonAmount.text = String(format: "$%0.2f", tipCalculator.totalAmount/Double(numberOfPeople))
        eachPersonAmount.sizeToFit()
        
    }
    // MARK: - Actions
    
    @IBAction func tipSliderValueChange(sender: Any){
        (sender as AnyObject).setValue((sender as AnyObject).value.rounded(.down), animated: true)
        tipPercentageLabel.text = String(format: "Tip: %02d%%", Int(tipPercentageSlider.value))
        calculateBill()
    }
    @IBAction func numberOfPeopleSliderChange(sender: Any){
        (sender as AnyObject).setValue((sender as AnyObject).value.rounded(.down), animated: true)
        numberOfPeopleLabel.text = String("Split: \(Int(numberOfPeopleSlider.value))")
        calculateBill()
    }
    @IBAction func amountBeforeTaxTextFieldChanged(_ sender: Any) {
        calculateBill()
    }
    
}
