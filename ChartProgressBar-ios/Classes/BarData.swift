
import Foundation

public struct BarData {

    public let barTitle: String
    public let barValue: Float
    public let pinText: String

    public init(barTitle title: String,
         barValue value: Float,
         pinText textPin: String) {

        barTitle = title
        barValue = value
        pinText = textPin
    }
}
