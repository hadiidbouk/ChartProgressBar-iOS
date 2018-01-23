
import UIKit

class SampleViewController: UIViewController, ChartProgressBarDelegate {

    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }


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
