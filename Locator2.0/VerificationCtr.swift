//
//  VerificationCtr.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import UIKit

class VerificationCtr: UIViewController {
    
    @IBOutlet weak var txtVerification: UITextField!

    
    @IBAction func verification(sender: AnyObject) {
        var objectUtilities: Utilities = Utilities()
        if (txtVerification.text).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        {
            objectUtilities.loadVerificationInfoFromServer(txtVerification.text)
            
            if objectUtilities.msgs.status == "200"
            {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(false, forKey: "Verification")
                defaults.setBool(true, forKey: "HasBeenLaunched")
                defaults.synchronize()
                
                let alert = UIAlertController(title: "Alerta", message: objectUtilities.msgs.msj, preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { action  in
                    let view: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("LoginCtr")
                    self.showViewController(view as UIViewController, sender: view)
                }
                
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else
        {
            println("Introduce el Codigo de verificacion enviado a tu correo")
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
