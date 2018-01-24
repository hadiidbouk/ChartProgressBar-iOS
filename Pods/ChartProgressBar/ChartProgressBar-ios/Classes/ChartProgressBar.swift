
import UIKit

public class ChartProgressBar: UIView {
	
	public var data: [BarData]?
	public var barWidth: Float = 15
	public var barHeight: Float = 180
	public var emptyColor: UIColor = UIColor.init(hexString: "e0e0e0")
	public var progressColor: UIColor = UIColor.init(hexString: "0086FF")
	public var progressDisableColor: UIColor = UIColor.init(hexString: "4bffffff")
	public var progressClickColor: UIColor = UIColor.init(hexString: "09467D")
	public var pinTxtColor: UIColor = UIColor.white
	public var pinBackgroundColor: UIColor = UIColor.darkGray
	public var barRadius: Float? = nil
	public var barTitleColor: UIColor = UIColor.init(hexString: "598DBC")
	public var barTitleSelectedColor: UIColor = UIColor.init(hexString: "FFFFFF")
	public var barTitleTxtSize: Float = 12
	public var barTitleWidth: Float = 30
	public var barTitleHeight: Float = 25
	public var pinTitleFont: UIFont?
	public var barTitleFont: UIFont?
	public var pinTxtSize: Float = 10
	public var pinWidth: Float = 30
	public var pinHeight: Float = 30
	public var pinMarginBottom: Float = 0
	public var pinMarginTop: Float = 0
	public var barsCanBeClick: Bool = false
	private var oldClickedBar: Bar?
	public var maxValue: Float = 100.0
	private var isDataEmpty: Bool = true
	public var delegate: ChartProgressBarDelegate?
	
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
		
		if pinTitleFont == nil {
			pinTitleFont = UIFont(name: "HelveticaNeue-bold", size: CGFloat(pinTxtSize))
		}
		
		if barTitleFont == nil {
			barTitleFont = UIFont(name: "HelveticaNeue-medium", size: CGFloat(barTitleTxtSize))
		}
		
		guard let chartData = data else {
			return
		}
		
		guard chartData.count != 0 else {
			return
		}
		
		let height = CGFloat(barHeight) > self.frame.height ? self.frame.height : CGFloat(barHeight)
		
		let stackView = UIStackView()
		stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
		stackView.axis = UILayoutConstraintAxis.horizontal
		stackView.distribution = UIStackViewDistribution.fillEqually
		
		let barViewWidth = (self.frame.width) / (CGFloat(chartData.count))
		
		var i = 0
		for barData in chartData {
			
			let barView = UIView()
			barView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
			
			let bar = Bar()
			
			bar.tag = i
			i = i + 1
			
			let xBar = (barViewWidth / 2) - (CGFloat(barWidth / 2))
			
			bar.frame = CGRect(x: xBar, y: 0, width: CGFloat(barWidth), height: height)
			bar.setBarRadius(radius: barRadius)
			bar.initBar()
			bar.setBackColor(emptyColor)
			bar.setProgressColor(progressColor)
			bar.setProgressValue(CGFloat(barData.barValue), threshold: CGFloat(maxValue))
			
			if barsCanBeClick {
				let gesture = UITapGestureRecognizer(target: self, action: #selector (self.triggerBarClick(sender:)))
				barView.addGestureRecognizer(gesture)
			}
			
			barView.addSubview(bar)
			
			let barPinLbl = createPinLbl(text: barData.pinText)
			let barPinView = createPinView(label: barPinLbl,
													 progressBar: bar,
													 progressValue: CGFloat(barData.barValue))
			
			barPinView.isHidden = true
			
			barView.addSubview(barPinView)
			
			let barTitleLbl = createBarTitleLbl(text: barData.barTitle,
															progressBar: bar,
															barFrame: xBar)
			
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
		
		let barView = sender.view
		guard let views = barView?.subviews else {
			return
		}
		
		for view in views {
			if(view is Bar) {
				setClick(on: oldClickedBar, isBarClicked: false)
				let bar = view as? Bar
				setClick(on: bar, isBarClicked: true)
				if bar != nil {
					delegate?.ChartProgressBar(self, didSelectRowAt: bar!.tag)
				}
			}
		}
	}
	
	/*
	Click a bar dynamically
	*/
	public func clickBar(index: Int) {
		guard isDataEmpty == false else {
			return
		}
		
		let stackView = self.subviews[0] as? UIStackView
		
		if stackView == nil {
			return
		}
		
		guard let barsViews = stackView?.arrangedSubviews else { return }
		
		for i in 0...barsViews.count - 1 {
			if i == index {
				let barView = barsViews[i]
				let views = barView.subviews
				for view in views {
					if(view is Bar) {
						let bar = view as! Bar
						setClick(on: oldClickedBar, isBarClicked: false)
						if !bar.isDisabled {
							setClick(on: bar, isBarClicked: true)
							delegate?.ChartProgressBar(self, didSelectRowAt: bar.tag)
						}
					}
				}
				return
			}
		}
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
					lbl.textColor = barTitleSelectedColor
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
	Disable a bar ( change color and remove gesture)
	*/
	public func disableBar(at index: Int) {
		var stackView: UIStackView? = nil
		self.subviews.forEach {
			if $0 is UIStackView {
				stackView = $0 as? UIStackView
			}
		}
		guard let barView = stackView?.arrangedSubviews[index] else {
			return
		}
		barView.gestureRecognizers?.removeAll()
		barView.subviews.forEach {
			if $0 is Bar {
				let bar = $0 as? Bar
				bar?.isDisabled = true
				bar?.setProgressColor(progressDisableColor)
			}
			else if $0 is UILabel {
				let titleBar = $0 as? UILabel
				titleBar?.textColor = progressDisableColor
			}
		}
	}
	
	/*
	Enable a bar ( change color and remove gesture)
	*/
	public func enableBar(at index: Int) {
		var stackView: UIStackView? = nil
		self.subviews.forEach {
			if $0 is UIStackView {
				stackView = $0 as? UIStackView
			}
		}
		guard let barView = stackView?.arrangedSubviews[index] else {
			return
		}
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector (self.triggerBarClick(sender:)))
		barView.addGestureRecognizer(gesture)
		
		barView.subviews.forEach {
			if $0 is Bar {
				let bar = $0 as? Bar
				bar?.isDisabled = false
				bar?.setProgressColor(progressColor)
			}
			else if $0 is UILabel {
				let titleBar = $0 as? UILabel
				titleBar?.textColor = barTitleColor
			}
		}
	}
	
	/*
	This method create the pin lbl and set the text from the BarData array
	*/
	private func createPinLbl(text newText: String) -> UILabel {
		
		let newLbl = UILabel()
		newLbl.frame = CGRect(x: 0, y: 0, width: CGFloat(pinWidth), height: CGFloat(pinHeight))
		newLbl.text = newText
		newLbl.textAlignment = .center
		newLbl.textColor = pinTxtColor
		newLbl.font = pinTitleFont
		
		return newLbl
	}
	
	/*
	This method create the pin view by getting the image from the bundle as an SVG using `SwiftSVG`(https://github.com/mchoe/SwiftSVG) library and adding the created label in the above method to it.
	*/
	private func createPinView(label lbl: UILabel, progressBar bar: Bar, progressValue value: CGFloat) -> UIView {
		
		let newView = UIView()
		
		var pinY = bar.frame.maxY - ((value * bar.frame.height) / CGFloat(maxValue)) - CGFloat(pinHeight)
		
		pinY = (pinY) + (CGFloat(pinMarginTop))
		pinY = (pinY) - (CGFloat(pinMarginBottom))
		
		newView.frame = CGRect(x: CGFloat(Float(bar.center.x) - Float(pinWidth / 2)) - 1, y: pinY, width: CGFloat(pinWidth), height: CGFloat(pinHeight))
		
		let bezierPath = UIBezierPath()
		bezierPath.move(to: CGPoint(x: 56.95, y: 0))
		bezierPath.addLine(to: CGPoint(x: 14.5, y: 0))
		bezierPath.addCurve(to: CGPoint(x: 0, y: 14.5), controlPoint1: CGPoint(x: 6.49, y: 0), controlPoint2: CGPoint(x: 0, y: 6.49))
		bezierPath.addCurve(to: CGPoint(x: 14.5, y: 29), controlPoint1: CGPoint(x: 0, y: 22.51), controlPoint2: CGPoint(x: 6.49, y: 29))
		bezierPath.addLine(to: CGPoint(x: 29.82, y: 29))
		bezierPath.addLine(to: CGPoint(x: 35.24, y: 34.02))
		bezierPath.addCurve(to: CGPoint(x: 36.15, y: 34.28), controlPoint1: CGPoint(x: 35.49, y: 34.28), controlPoint2: CGPoint(x: 35.9, y: 34.54))
		bezierPath.addLine(to: CGPoint(x: 41.66, y: 29))
		bezierPath.addLine(to: CGPoint(x: 56.95, y: 29))
		bezierPath.addCurve(to: CGPoint(x: 71.45, y: 14.5), controlPoint1: CGPoint(x: 64.96, y: 29), controlPoint2: CGPoint(x: 71.45, y: 22.51))
		bezierPath.addCurve(to: CGPoint(x: 56.95, y: 0), controlPoint1: CGPoint(x: 71.45, y: 6.49), controlPoint2: CGPoint(x: 64.96, y: 0))
		bezierPath.close()
		pinBackgroundColor.setFill()
		bezierPath.fill()
		
		let pinCALayer = CAShapeLayer()
		pinCALayer.path = bezierPath.cgPath
		pinCALayer.fillColor = pinBackgroundColor.cgColor
		
		newView.layer.addSublayer(pinCALayer)
		newView.addSubview(lbl)
		
		return newView
	}
	
	/*
	This method create the bar title below the bar and get the text from the BarData array
	*/
	private func createBarTitleLbl(text newText: String, progressBar bar: Bar, barFrame: CGFloat) -> UILabel {
		
		let newLbl = UILabel()
		
		var x = barFrame
		newLbl.frame = CGRect(x: x, y: bar.frame.maxY, width: CGFloat(barTitleWidth), height: CGFloat(barTitleHeight))
		
		let labelx = newLbl.frame.origin.x
		x = x - (labelx / 2)
		newLbl.frame.origin.x = x
		newLbl.text = newText
		newLbl.textAlignment = .center
		newLbl.textColor = barTitleColor
		newLbl.font = barTitleFont
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

