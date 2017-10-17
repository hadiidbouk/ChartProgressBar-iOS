# ChartProgressBar-iOS

Draw a chart with progress bar style - the android version [here](https://github.com/hadiidbouk/ChartProgressBar-Android)

![](https://i.imgur.com/ppZiu4s.png)

## Installation

// ios version (9.0,*)

Using cocoapods : ```pod 'ChartProgressBar' ```

(this pod will add SwiftSVG also)

Or 

Clone this repo and copy all the files

## Usage

Add a UIView and set class name 'ChartProgressBar'

![](https://i.imgur.com/l3utMxR.png)

2. Add your Data to the chart :

```swift
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
        //chart.barWidth = 15
	//chart.barHeight = 180
	//chart.emptyColor = UIColor.init(hexString: "e0e0e0")
	//chart.progressColor = UIColor.init(hexString: "0086FF")
	//chart.progressClickColor = UIColor.init(hexString: "09467D")
	//chart.pinTxtColor = UIColor.white
	//chart.pinBackgroundColor = UIColor.darkGray
	//chart.barRadius = 5
	//chart.barTitleColor = UIColor.init(hexString: "598DBC")
	//chart.barTitleTxtSize = 12
	//chart.barTitleWidth = 30
	//chart.barTitleHeight = 25
	//chart.pinTxtSize = 10
	//chart.pinWidth = 30
	//chart.pinHeigh = 30
        chart.build()
    }
```

## Useful methods

1. `chart.removeValues()` : Remove values of all progress bars in the chart.

2. `chart.resetValues()` : Set values to the chart ( it may used after `removeBarValues()`) .

3. `chart.removeClickedBar()` : Unselect the clicked bar.

4. `isBarsEmpty()` : Check if bars values are empty.

## Credits

this library use [AlNistor](https://github.com/AlNistor/vertical-progress-bar-swift) sample to draw a single bar and [SwiftSVG](https://github.com/mchoe/SwiftSVG) to show and edit the svg pin.

Thanks for [Simplexity](http://simplexity.io) that gave me time for doing this library.
