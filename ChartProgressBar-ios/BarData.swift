//
//  BarData.swift
//  ChartProgressBar-ios
//
//  Created by Hadi Dbouk on 10/11/17.
//  Copyright © 2017 Hadi Dbouk. All rights reserved.
//

import Foundation

struct BarData {

    let barTitle: String
    let barValue: Float
    let pinText: String

    init(barTitle title: String,
         barValue value: Float,
         pinText textPin: String) {

        barTitle = title
        barValue = value
        pinText = textPin
    }
}
