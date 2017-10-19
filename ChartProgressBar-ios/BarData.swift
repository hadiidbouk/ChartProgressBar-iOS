
import Foundation

public struct BarData {

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
