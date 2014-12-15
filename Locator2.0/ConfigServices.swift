//
//  ConfigServices.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import Foundation

import Foundation

class configServices {
    let serviceRegister = "http://libra.itmorelia.edu.mx/localizador/rest.php/SET/unit"
    let serviceVerify = "http://libra.itmorelia.edu.mx/localizador/rest.php/GET/reg"
    
    var status:String = ""
    var msj:String = ""
    var data: String = ""
    var extra: String = ""
    
    func reset(){
        self.status = ""
        self.msj = ""
        self.data = ""
        self.extra = ""
    }
    deinit {
        println("objeto eliminado")
    }
}