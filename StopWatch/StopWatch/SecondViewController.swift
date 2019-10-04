import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    var counter = 30
    var running = false
    var timer1 = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPlay(_ sender: Any) {
        if !running{
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            running = true
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
            timer1.invalidate()
            running = false
    }
    
    @IBAction func buttonStop(_ sender: Any) {
            timer1.invalidate()
            running = false
            counter = 0
            timer.text = "00:00:00"
    }
    
    @objc func UpdateTime(){
        counter-=1;
        var s0 = "0"
        var s1 = "0"
        var s2 = "0"
        let d0 = counter/3600
        let d1 = (counter/60)%60
        var d2 = 0
        if counter > 0 {
            d2 = counter%60
        }
        if counter/3600>=10 {s0=""}
        if (counter/60)%60>=10 {s1=""}
        if counter%60>=10 {s2=""}
        timer.text = String(format:"%@%d:%@%d:%@%d",s0,d0,s1,d1,s2,d2)
        if counter == 0 {
            timer1.invalidate()
            running = false
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        if !running {
        let time = Int(sender.value)
        var s0 = "0"
            counter = time
            if time>=10 && time<60{
                s0=""
            }
            var d1 = 0
            if time > 0{
                d1 = time % 60
            }
        timer.text = String(format:"00:0%d:%@%d",time/60,s0,d1)
        }
        
    }
}
