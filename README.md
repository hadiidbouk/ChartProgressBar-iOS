# ChartProgressBar-ios

Draw a chart with progress bar style

![](https://i.imgur.com/ppZiu4s.png)

## Installation

clone this repo for now.
- it will be added to cocoapods

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
        chart.build()
    }
```

## Useful methods

1. `chart.removeValues()` : Remove values of all progress bars in the chart.

2. `chart.resetValues()` : Set values to the chart ( it may used after `removeBarValues()`) .

3. `chart.removeClickedBar()` : Unselect the clicked bar.

4. `isBarsEmpty()` : Check if bars values are empty.
