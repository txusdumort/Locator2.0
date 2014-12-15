//
//  Utilities.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import UIKit

class Utilities {
    let urlSaveFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let userDataFile = "/udsaetra.ksk"
    let credentialsFile = "/crd.ksk"
    
    var msgs:configServices = configServices()
    
    //Function Section Starts
    
    func verifyFields(fields: [String]) -> Bool {
        for(component) in fields {
            if component.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
                return false
            }
        }
        return true
    }
    
    func saveUserData(fields: [String]){
        var webservice: WebServiceAPI = WebServiceAPI()
        var dataJSON:NSData = webservice.sendDataToServer(fields)!
        
        var JSONDict:NSDictionary =  NSJSONSerialization.JSONObjectWithData(dataJSON, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        msgs = asignJSONToMessageObject(JSONDict)
        
        if(msgs.status == "200")
        {
            writeToFile(userDataFile, data: fields, extraData: "^^\(msgs.data)")
        }
    }
    
    func saveCredentials(fields: [String]){
        writeToFile(credentialsFile, data: fields, extraData: "")
    }
    
    func loadVerificationInfoFromServer(code: String){
        var webservice: WebServiceAPI = WebServiceAPI()
        var aux = (readFile(userDataFile).componentsSeparatedByString("^^")[1]).componentsSeparatedByString("|")
        var dataDevice = [aux[0], aux[1], code]
        println(dataDevice)
        var dataJSON:NSData = webservice.verifyCodeWithServer(dataDevice)!
        
        var JSONDict:NSDictionary =  NSJSONSerialization.JSONObjectWithData(dataJSON, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        msgs = asignJSONToMessageObject(JSONDict)
    }
    
    func asignJSONToMessageObject(JSONDict: NSDictionary) -> configServices {
        var msgs: configServices = configServices()
        msgs.reset()
        if JSONDict.count > 0
        {
            if let content = JSONDict["results"] as? NSDictionary {
                if let status = content["status"] as? String{
                    msgs.status = status
                }
                if let msj = content["msj"] as? String{
                    msgs.msj = msj
                }
                if let data = content["data"] as? String{
                    msgs.data = data
                }
                if let extra = content["extra"] as? String{
                    msgs.extra = extra
                }
            }
        }
        
        return msgs
    }
    
    func writeToFile(fileName: String, data:[String], extraData:String?) -> Bool{
        var writeError: NSError? = nil
        
        let pathToTheFile = urlSaveFolder.stringByAppendingString(fileName)
        let fileManager  = NSFileManager.defaultManager()
        
        let contentFile = join("|", data).stringByAppendingString(extraData!)
        
        if !fileManager.fileExistsAtPath(pathToTheFile)
        {
            let fileWritten = contentFile.writeToFile(pathToTheFile, atomically: true, encoding: NSUTF8StringEncoding, error: &writeError)
            if writeError != nil
            {
                return false
            }
            println("File written: \(contentFile)")
        }
        return true
    }
    
    func readFile(fileName: String) -> String{
        let pathToTheFile = urlSaveFolder.stringByAppendingString(fileName)
        let contentFile:String = String(contentsOfFile: pathToTheFile, encoding: NSUTF8StringEncoding, error: nil)!
        
        return contentFile
    }
    
    func toShowCustomAlertWithMessageObject(msgs:configServices){
        var alert: UIAlertView = UIAlertView()
        alert.title = "Localizador"
        alert.message = "\n\(msgs.msj)\n\(msgs.data)\n\(msgs.extra)"
        alert.addButtonWithTitle("Aceptar")
        alert.show()
    }
    
    deinit{
        println(" objeto terminado")
    }
}