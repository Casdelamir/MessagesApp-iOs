//
//  MainPageViewController.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 16/9/24.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = "usernmane123"

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
