//
//  GeneralObject.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
struct GeneralObject {
    var id: Int = 0
    var code:String = ""
    var name:String = ""
    var address:String = ""
    var isSelected = 0
    
   
    init?() {}
    
    init?(id:Int=0,name:String="",isSelected:Int=0) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
    
    init?(id:Int=0,name:String="",address:String = "",isSelected:Int=0) {
        self.id = id
        self.name = name
        self.address = address
        self.isSelected = isSelected
    }
    
    
    init?(id:Int=0,code:String = "",name:String="",isSelected:Int=0) {
        self.id = id
        self.code = code
        self.name = name
        self.isSelected = isSelected
    }
  
   
}
