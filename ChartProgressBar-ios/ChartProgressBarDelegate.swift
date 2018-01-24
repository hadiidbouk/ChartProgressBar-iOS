//
//  ChartProgressBarDelegate.swift
//  ChartProgressBar-ios
//
//  Created by Hadi Dbouk on 1/15/18.
//  Copyright © 2018 Hadi Dbouk. All rights reserved.
//

import Foundation

public protocol ChartProgressBarDelegate {
    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int)
}
