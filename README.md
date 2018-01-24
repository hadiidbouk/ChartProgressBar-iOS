# ChartProgressBar-iOS

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://github.com/hadiidbouk/ChartProgressBar-iOS/blob/master/LICENSE)

Draw a chart with progress bar style - the android version [here](https://github.com/hadiidbouk/ChartProgressBar-Android)

![](https://i.imgur.com/bMB49fa.png)

## Installation

iOS version (9.0,*)

Swift 3.2

Using cocoapods : ```pod 'ChartProgressBar' ```

![](https://cocoapod-badges.herokuapp.com/v/ChartProgressBar/$VERSION/badge.png)

Or 

Clone this repo and copy all the files

## Usage

Add a UIView and set class name 'ChartProgressBar' ,
set the width and the height of this UIView

![](https://i.imgur.com/l3utMxR.png)

2. Add your Data to the chart :

```swift

import UIKit
import ChartProgressBar

class ViewController: UIViewController, ChartProgressBarDelegate {

@IBOutlet weak var chart: ChartProgressBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var data: [BarData] = []

        data.append(BarData.init(barTitle: "Jan", barValue: 1.4, pinText: "1.4 €"))
        data.append(BarData.init(barTitle: "Feb", barValue: 10, pinText: "10 €"))
        data.append(BarData.init(barTitle: "Mar", barValue: 3.1, pinText: "3.1 €"))
        data.append(BarData.init(barTitle: "Apr", barValue: 4.8, pinText: "4.8 €"))
        data.append(BarData.init(barTitle: "May", barValue: 6.6, pinText: "6.6 €"))
        data.append(BarData.init(barTitle: "Jun", barValue: 7.4, pinText: "7.4 €"))
        data.append(BarData.init(barTitle: "Jul", barValue: 5.5, pinText: "5.5 €"))

        chart.data = data
        chart.barsCanBeClick = true
        chart.maxValue = 10.0
        chart.emptyColor = UIColor.clear
        chart.barWidth = 7
        chart.progressColor = UIColor.init(hexString: "99ffffff")
        chart.progressClickColor = UIColor.init(hexString: "F2912C")
        chart.pinBackgroundColor = UIColor.init(hexString: "E2335E")
        chart.pinTxtColor = UIColor.init(hexString: "ffffff")
        chart.barTitleColor = UIColor.init(hexString: "B6BDD5")
        chart.barTitleSelectedColor = UIColor.init(hexString: "FFFFFF")
        chart.pinMarginBottom = 15
        chart.pinWidth = 70
        chart.pinHeight = 29
        chart.pinTxtSize = 17
        chart.delegate = self
        chart.build()
	
        chart.disableBar(at: 3)
	
	let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chart.enableBar(at: 3)
        }
    }   
  }
```

  To Handle ChartProgressBarDelegate
  
```
  extension MainViewController: ChartProgressBarDelegate {
    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }
}
```

## Useful methods

1. `chart.removeValues()` : Remove values of all progress bars in the chart.

2. `chart.resetValues()` : Set values to the chart ( it may used after `removeBarValues()`) .

3. `chart.removeClickedBar()` : Unselect the clicked bar.

4. `isBarsEmpty()` : Check if bars values are empty.

5. `chart.disableBar(at: Int)` : Disable a bar progmatically.

6. `chart.enableBar(at: Int)` : Enable a bar progmatically.

7. `clickBar(index: Int)` : Click a bar progmatically.

## Credits

this library use [AlNistor](https://github.com/AlNistor/vertical-progress-bar-swift) sample to draw a single bar.

Thanks for [Simplexity](http://simplexity.io) that gave me time for doing this library.
