import UIKit

class postViewController: UIViewController {
    var select:Score?
    @IBOutlet var label1: UILabel!
    

    @IBOutlet var text2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text=select?.score
        text2.text=select?.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
