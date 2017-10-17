//
//  ChartProgressBar.swift
//  ChartProgressBar-ios
//
//  Created by Hadi Dbouk on 10/11/17.
//  Copyright © 2017 Hadi Dbouk. All rights reserved.
//

import UIKit
import SwiftSVG

@available(iOS 9.0, *)
public class ChartProgressBar: UIView {

	public var data: [BarData]?
	public var barWidth: Float = 15
	public var barHeight: Float = 180
	public var emptyColor: UIColor = UIColor.init(hexString: "e0e0e0")
	public var progressColor: UIColor = UIColor.init(hexString: "0086FF")
	public var progressClickColor: UIColor = UIColor.init(hexString: "09467D")
	public var pinTxtColor: UIColor = UIColor.white
	public var pinBackgroundColor: UIColor = UIColor.darkGray
	public var barRadius: Float? = nil
	public var barTitleColor: UIColor = UIColor.init(hexString: "598DBC")
	public var barTitleTxtSize: Float = 12
	public var barTitleWidth: Float = 30
	public var barTitleHeight: Float = 25
	public var pinTxtSize: Float = 10
	public var pinWidth: Float = 30
	public var pinHeight: Float = 30
	public var barsCanBeClick: Bool = false
	private var oldClickedBar: Bar?
	public var maxValue: Float = 100.0
	private var isDataEmpty: Bool = true

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	/*  build the chart
        this method build the progress bar into a stackview
     */
	public func build() {

		guard let chartData = data else {
			return
		}


		let width = CGFloat(barWidth) > self.frame.width ? self.frame.width : CGFloat(barWidth)
		let height = CGFloat(barHeight) > self.frame.height ? self.frame.height : CGFloat(barHeight)

		let stackView = UIStackView()
		stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
		stackView.axis = UILayoutConstraintAxis.horizontal
		stackView.distribution = UIStackViewDistribution.fillEqually

		for barData in chartData {


			let barView = UIView()
			barView.frame = CGRect(x: 0, y: 0, width: width, height: height)

			let bar = Bar()

			bar.frame = CGRect(x: barView.center.x + barView.frame.width / 2, y: 0, width: width, height: height)
			bar.setBarRadius(radius: barRadius)
			bar.initBar()
			bar.setBackColor(emptyColor)
			bar.setProgressColor(progressColor)
			bar.setProgressValue(CGFloat(barData.barValue), threshold: CGFloat(maxValue))

			if barsCanBeClick {
				let gesture = UITapGestureRecognizer(target: self, action: #selector (self.triggerBarClick(sender:)))
				bar.addGestureRecognizer(gesture)
			}

			barView.addSubview(bar)

			let barPinLbl = createPinLbl(text: barData.pinText)
			let barPinView = createPinView(label: barPinLbl, progressBar: bar, progressValue: CGFloat(barData.barValue))

			barPinView.isHidden = true

			barView.addSubview(barPinView)

			let barTitleLbl = createBarTitleLbl(text: barData.barTitle, progressBar: bar)

			barView.addSubview(barTitleLbl)

			stackView.addArrangedSubview(barView)
		}
		self.addSubview(stackView)

		isDataEmpty = false
	}

	/*
        This method handle the bar click 
        for showing the pin and changing the bar color
     */
	@objc private func triggerBarClick(sender: UITapGestureRecognizer) {

		guard isDataEmpty == false else {
			return
		}

		let bar = sender.view as? Bar

		setClick(on: oldClickedBar, isBarClicked: false)
		setClick(on: bar, isBarClicked: true)
	}

	/*
     This is a helper method of 'triggerBarClick'
     it taks the bar has been clicked ( or not ) and show/hide the pin
     it will be used to hide the old bar also
     */
	private func setClick(on bar: Bar?, isBarClicked isClicked: Bool) {

		guard let barView = bar?.superview else {
			return
		}

		for subView in barView.subviews {

			let isLabel = subView is UILabel
			let isBar = subView is Bar

			if !isLabel && !isBar {

				subView.isHidden = !isClicked
				oldClickedBar = bar
			}
				else if isBar {

					if isClicked {
						bar?.setProgressColor(progressClickColor)

					}
						else {
							bar?.setProgressColor(progressColor)
					}
			}
				else if isLabel && subView.tag == 778877 {

					let lbl = subView as! UILabel

					if isClicked {
						lbl.textColor = progressClickColor
					}
						else {
							lbl.textColor = barTitleColor
					}
			}
		}
	}

	/*
        This method remove all the values of the chart by setting the value 0 ,
        also it calls 'removeClickedBar()'.
     */
	public func removeValues() {

		removeClickedBar()

		let stackView = self.subviews[0]

		for barView in stackView.subviews {

			for subView in barView.subviews {

				if subView is Bar {

					let bar = subView as! Bar
					bar.setProgressValue(0, threshold: CGFloat(maxValue))
				}

			}
		}
		isDataEmpty = true
	}

	/*
     This method re-add all the values of the chart by setting the value from the BarData array.
     */
	public func resetValues() {

		var i = 0

		let stackView = self.subviews[0]

		for barView in stackView.subviews {

			for subView in barView.subviews {

				if subView is Bar {

					let bar = subView as! Bar
					bar.setProgressValue(CGFloat(data![i].barValue), threshold: CGFloat(maxValue))
					i = i + 1
				}

			}
		}
		isDataEmpty = false
	}

	/*
     This method hide the pin and set the progress (and the title ) color to progresscolor.
     */
	public func removeClickedBar() {
		setClick(on: oldClickedBar, isBarClicked: false)
	}

	/*
     This method return true if the values of the charts in 0 otherwise it will return false
     */
	public func isBarsEmpty() -> Bool {
		return isDataEmpty
	}


	/*
     This method create the pin lbl and set the text from the BarData array
     */
	private func createPinLbl(text newText: String) -> UILabel {

		let newLbl = UILabel()
		newLbl.frame = CGRect(x: 0, y: -2, width: CGFloat(pinWidth), height: CGFloat(pinHeight))
		newLbl.text = newText
		newLbl.textAlignment = .center
		newLbl.textColor = pinTxtColor
		newLbl.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(pinTxtSize))

		return newLbl
	}

	/*
     This method create the pin view by getting the image from the bundle as an SVG using `SwiftSVG`(https://github.com/mchoe/SwiftSVG) library and adding the created label in the above method to it.
     */
	private func createPinView(label lbl: UILabel, progressBar bar: Bar, progressValue value: CGFloat) -> UIView {

		let newView = UIView()

		let pinY = (bar.frame.maxY - (value.multiplied(by: bar.frame.height)).divided(by: CGFloat(maxValue))).subtracting(CGFloat(pinHeight))

		newView.frame = CGRect(x: CGFloat(Float(bar.center.x) - Float(pinWidth / 2)), y: pinY, width: CGFloat(pinWidth), height: CGFloat(pinHeight))

        let bundle = Bundle(for: ChartProgressBar.self)
        
        let svgURL = bundle.url(forResource: "pin", withExtension: "svg")!

		CALayer(SVGURL: svgURL) { (svgLayer) in

			svgLayer.resizeToFit(CGRect(x: 0, y: 0, width: CGFloat(self.pinWidth), height: CGFloat(self.pinHeight)))
			svgLayer.fillColor = self.pinBackgroundColor.cgColor

			newView.layer.addSublayer(svgLayer)
			newView.addSubview(lbl)
		}


		return newView
	}

	/*
        This method create the bar title below the bar and get the text from the BarData array
     */
	private func createBarTitleLbl(text newText: String, progressBar bar: Bar) -> UILabel {

		let newLbl = UILabel()
		newLbl.frame = CGRect(x: CGFloat(Float(bar.superview!.center.x)), y: bar.frame.maxY, width: CGFloat(barTitleWidth), height: CGFloat(barTitleHeight))
		newLbl.text = newText
		newLbl.textAlignment = .center
		newLbl.textColor = barTitleColor
		newLbl.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(barTitleTxtSize))
		newLbl.tag = 778877

		return newLbl
	}
}

extension UIColor {
	convenience init(hexString: String) {
		let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt32()
		Scanner(string: hex).scanHexInt32(&int)
		let a, r, g, b: UInt32
		switch hex.characters.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
	}
}
