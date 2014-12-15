//
//  WebServiceAPI.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import Foundation

class WebServiceAPI: NSObject {
    
    func createURL(URLString:String, arguments:[String]) -> String{
        var s:String = URLString
        for(component) in arguments {
            var clearUrlStructured = component.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            s += "\(clearUrlStructured)/"
        }
        return s
    }
    
    func sendDataToServer(urlStructured:[String]) -> NSData? {
        var settings:configServices = configServices()
        var urlPath:String = createURL("\(settings.serviceRegister)/", arguments: urlStructured)
        var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
        var error: AutoreleasingUnsafeMutablePointer<NSErrorPointer?> = nil;
        
        var responseData = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: urlPath)!),returningResponse: response, error:nil) as NSData!
        
        if error == nil
        {
            //return NSJSONSerialization.JSONObjectWithData(responseData,options: NSJSONReadingOptions.MutableContainers, error:nil) as NSDictionary
            return responseData
           // delegate?.didReceiveResponse(responseDict)
        }
        else
        {
            println("erro")
            
        }
        return nil
        //return responseData
    }
    
    func verifyCodeWithServer(urlStructured:[String]) -> NSData? {
        var settings:configServices = configServices()
        var urlPath:String = createURL("\(settings.serviceVerify)/", arguments: urlStructured)
        var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
        var error: AutoreleasingUnsafeMutablePointer<NSErrorPointer?> = nil;
        println(urlPath)
        var responseData = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: urlPath)!),returningResponse: response, error:nil) as NSData!
        
        if error == nil
        {
            return responseData
        }
        else
        {
            println("erro")
            
        }
        
        return nil
        /*var settings:configServices = configServices()
        var urlPath = createURL("\(settings.serviceVerify)/", arguments: urlStructured)
        
        //falta hacer sincrona
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        
        connection.start()*/
    }
    
    deinit {
        println("objeto eliminado")
    }

    /*
    func connection(connection:NSURLConnection!, didFailWithError error:NSError!) {
        println("Failed  with error \(error.localizedDescription)")
        
        var alert: UIAlertView = UIAlertView()
        alert.title = "Sin conexion"
        alert.message = "No se ha podido conectar con el servidor"
        alert.addButtonWithTitle("Aceptar")
        alert.show()
    }
    
    func connection(connection:NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        var nsErr: NSError?
        var jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &nsErr)
        
        if let err = nsErr {
            var errorString = "Error en el JSON generado por el Web Service: " + nsErr!.localizedDescription
            println(errorString)
            
            var alert: UIAlertView = UIAlertView()
            alert.title = "Atencion"
            alert.message = errorString
            alert.addButtonWithTitle("Aceptar")
            alert.show()
        }
        
        println("Web service Returned: ")
        println(jsonResult)
        
        var jsonDict = jsonResult as NSDictionary
        delegate?.didReceiveResponse(jsonDict)
        
    }*/
    
    
}