//
//  postViewController.swift
//  期末-天氣app
//
//  Created by User02 on 2019/6/22.
//  Copyright © 2019 00657123. All rights reserved.
//

import UIKit

class postViewController: UIViewController {
    var select:Daily?
    @IBOutlet var label1: UILabel!
    

    @IBOutlet var text2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text=select?.theme
        text2.text=select?.dailytext
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
