//
//  GradeViewController.swift
//  00457045_HW3
//
//  Created by User23 on 2019/6/25.
//  Copyright © 2019 Lin. All rights reserved.
//

import UIKit

class GradeViewController: UIViewController {
    
    @IBOutlet weak var NameTextView: UITextView!
    @IBOutlet weak var ScoreTextView: UITextView!
    @IBOutlet weak var CompleteButton: UIBarButtonItem!
    var name : String?
    var score : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let Grade = segue.destination as? ViewController else{return}
        let name = NameTextView.text
        let score = ScoreTextView.text
        //Grade.Name = NameTextView.text
        //Grade.Score = ScoreTextView.text
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
