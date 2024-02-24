//
//  EmployeeListManagementRouter.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class EmployeeListManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = EmployeeListManagementViewController(nibName: "EmployeeListManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToDetailEmployeeViewController(employeeList:Account,isAllowEditing:Bool){
        let detailEmployeeViewcontroller = DetailEmployeeRouter().viewController as? DetailEmployeeViewController
        detailEmployeeViewcontroller!.employeeInfor = employeeList
        detailEmployeeViewcontroller!.isAllowEditing = isAllowEditing
        if employeeList.id > 0 {
            detailEmployeeViewcontroller?.moduleType = "UPDATEEMPLOYEE"
        }else {
            detailEmployeeViewcontroller?.moduleType = "CREATE"
        }
       
        sourceView?.navigationController?.pushViewController(detailEmployeeViewcontroller!, animated: true)
    }
    
    
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
      }
}
