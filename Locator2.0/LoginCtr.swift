//
//  LoginCtr.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import UIKit

class LoginCtr: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBAction func login(sender: AnyObject) {
        var credentials = "\(txtUsername.text)|\(txtPassword.text)|\(txtPassword.text)"
        var objectUtilities: Utilities = Utilities()
        
        if credentials == objectUtilities.readFile(objectUtilities.credentialsFile)
        {
            let view: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("MasterCtr")
            self.showViewController(view as UIViewController, sender: view)
        }
        else
        {
            println("credenciales incorrectas")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
