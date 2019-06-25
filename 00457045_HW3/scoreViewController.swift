import UIKit


class scoreViewController: UIViewController {
    var date:Score?

    
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var score: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var dateFormat:DateFormatter
        dateFormat = DateFormatter().self
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let dateInput=score.text ?? ""
        let datestring = dateFormat.string(from: Date.init())
        let dateTheme = name.text ?? ""
        date=Score(name: dateInput, date: datestring,score:dateTheme)
        
    }

}
