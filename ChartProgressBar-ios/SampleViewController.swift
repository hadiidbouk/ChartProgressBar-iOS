//
//  SampleViewController.swift
//  ChartProgressBar-ios
//
//  Created by Hadi Dbouk on 10/12/17.
//  Copyright © 2017 Hadi Dbouk. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    @IBOutlet weak var chart: ChartProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var data: [BarData] = []
        
        data.append(BarData.init(barTitle: "Jan", barValue: 1.4, pinText: "1.4$"))
        data.append(BarData.init(barTitle: "Feb", barValue: 10, pinText: "10$"))
        data.append(BarData.init(barTitle: "Mar", barValue: 3.1, pinText: "3.1$"))
        data.append(BarData.init(barTitle: "Apr", barValue: 4.8, pinText: "4.8$"))
        data.append(BarData.init(barTitle: "May", barValue: 6.6, pinText: "6.6$"))
        data.append(BarData.init(barTitle: "Jun", barValue: 7.4, pinText: "7.4$"))
        data.append(BarData.init(barTitle: "Jul", barValue: 5.5, pinText: "5.5$"))
        
        chart.data = data
        chart.barsCanBeClick = true
        chart.maxValue = 10.0
        chart.build()
    }
    
    @IBAction func removeValues(_ sender: Any) {
        chart.removeValues()
    }
    
    @IBAction func isBarsEmpty(_ sender: Any) {
        
        let alert = UIAlertController(title: "Is bars Empty ?", message: "\(chart.isBarsEmpty())", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetValues(_ sender: Any) {
        chart.resetValues()
    }
    
    @IBAction func removeClickedBar(_ sender: Any) {
        chart.removeClickedBar()
    }
}
