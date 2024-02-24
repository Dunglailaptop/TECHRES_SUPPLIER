//
//  HandlerDelegate.swift
//  Techres-Seemt
//
//  Created by Kelvin on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Photos

//========== Protocol Supplier Orders =========
protocol SupplierOrdersDelegate {
    func callBackCancelSupplierOrders(cancel_reason:String)
    func callBackAcceptSupplierOrders(index: Int)
}
protocol LockEmployeeDelegate {
    func callBackLockEmployee(position:Int, lockId:Int, type: Int,usernames:String,note_noty:String)
}

protocol ResetPasswordDelegate {
    func callBackResetPasswordEmployee(Employee:Account)
}

protocol ArrayChooseCategoryViewControllerDelegate {
    func selectCategoryAt(pos: Int)
}
protocol AccountInforDelegate{
        func callBackToAcceptSelectedArea(selectedArea:[String:Area])
}

    
protocol CalculatorMoneyDelegate {
    func callBackCalculatorMoney(amount:Int, position:Int,MaterialId:Int)
}
protocol CaculatorDelegate{
    func callbackToGetResult(number:Double)
}

protocol ArrayShowDropdownViewControllerDelegate {
    func selectAt(pos: Int)
}

//========== Protocol Input money =========
protocol InputMoneyDelegate {
    func callBackInputMoney(amount:Int, position:Int)
}
protocol InputQuantityDelegate {
    func callbackInputQuantity(number:Float, position:Int)
}

protocol ShowInputQuantityDelegate {
    func callbackShowInputQuantity()
}
protocol ShowInputMoneyDelegate {
    func callbackShowInputMoney(current_money: Int, position: Int)
}

//========== Protocol Supplier Warehouse Sessions =========
protocol SupplierWarehouseSessionsDelegate {
    func callBackAcceptSupplierWarehouse(index: Int)
}

//========== Protocol Supplier Debt Payment Bill =========
protocol SupplierDebtPaymentBillDelegate {
    func callBackAcceptSupplierDebtPaymentBill()
}
//========== Protocol Price List Detail =========

protocol ShowInputMoneyPriceListDelegate {
    func callbackShowInputPriceList()
    
}
protocol InputMoneyDelegatePriceList {
    func callbackInputPriceList(amount:Int,materialPriceList:MaterialPriceList)
}
//=========== Account ============================
protocol DialogConfirmDelegate{
    func callBackToConfirm()
}

protocol DialogRejectDelegate{
    func callBackToReject(reason:String)
}

protocol PaymentRequestFilterDelegate{
    func callBackToConfirm(restaurant_id:Int, brand_id:Int, branch_id:Int)
}

protocol UpdateSettingBusiness{
    func callUpdateBusiness()
}

//========== Protocol Choose Input money =========
protocol ChooseInputMoneyDelegate {
    func callBackChooseInputMoney(amount:Int, percent:Float)
    func callBackCancelChooseInputMoney()
}

protocol CreatePaymentRequestPopupDelegate{
    func callBackToGetResult(restaurant:Restaurant, brand:Restaurant,branch:Restaurant)
}

protocol SupplierRequestMaterialDelegate{
    func callBackToAcceptRequestSupplierMaterial(dataMaterial: [Material])
}

protocol DialogChooseRestaurantDelegate{
    func callBackToGetResult(restaurant:Restaurant, brand:Brand,branch:Branches)
}

protocol DialogDelegate{
    func callBackToGetSingleResult(result:GeneralObject)
    func callBackToGetMultipleResult(results:[GeneralObject])
}






//=========== Protocol Create Employee =======
protocol DialogAccessCreate{
    func callBackCreateEmployee()
}

protocol ReceiptAndPaymentCatetoryDelegate{
    func callBackToShowDialogConfirm(content:String)
}


protocol DialogAccessCancelSupplierDetailedPayment {
    func callBackCancelDetailedPayment(id:Int,status:Int)
}

protocol DialogConfrimCreateEmployee {
    func callBackDialogConfrimCreateEmployeePopup(check:Int)
}

protocol DialogConfrimUpdateEmployee {
    func callBackDialogUpdateEmployee()
}

protocol DialogResetPassword {
    func callbackDialogResetPassword(type:Int)
}
