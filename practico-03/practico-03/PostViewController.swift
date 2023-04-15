//
//  PostViewController.swift
//  practico-03
//
//  Created by Manuela Garcia Lira on 14/4/23.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postView: UIView!
    
    public var myPostView: UIView {
        return postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
