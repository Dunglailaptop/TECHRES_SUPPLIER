//
//  ManagerConections.swift
//  Supplier
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import NVActivityIndicatorView


enum ManagerConections: TargetType {
    // ========= API BUSINESS JAVA CORE =======
    case sessions
    case config(supplier_name:String)
    case registerDevice
    case login(supplier_name:String, username:String, password:String)
    case setting
//    === Tien Dung Management Employee ====
    case employees(status:Int,key_search:String,limit:Int,page:Int)
    case employeInfo(employeeId:Int)
    case employeeLock(id: Int)
    case employeeUpdateInfo(id: Int, DetailEmployeeRequest: DetailProfileEmployee )
    case getsupplierroles //lấy danh sách quyền nhân viên
    case cities(limit : Int = 200)
    case districts(city_id:Int ,limit : Int = 200)
    case wards(district_id:Int, limit : Int = 200)
    case createEmployee(DetailEmployeeNew: DetailProfileEmployee)
    case generateFileNameResource(medias:[Media])
    case getSupplierInfo
    case updateSupplierInfoBusiness(  name:String,email:String,phone:String,address:String,tax_code:String,website:String,description:String,avatar:String,information:String,city_id:Int,district_id:Int,ward_id:Int,cover_photo:String,supplier_business_type_id:[Int])
    case getListSupplierDebtPayment(from_date:String,to_date:String,status:String,payment_status:String)
    case getListSupplierWarehouseSessions(from_date:String,to_date:String,type:Int,status:Int,payment_status:String)
    //================================ Tien Dung ===========================
    //=== QUEN MAT KHAU ===//
    case forgotPassword(username:String)
    case verifyChangePassword(username:String, verify_code:String, new_password:String, node_access_token:String, device_uid:String, app_type:Int)
    case verifyCode(supplier_name:String, user_name: String, verify_code:String)
    //=== QUAN LY BANG GIA ===//
    case getListSupplier(key_search:String)
    case getSupplierMaterials(Supplier_id:Int)
    case notifications(type:Int, is_viewed:Int, page:Int, limit:Int)
    //Báo cái doanh thu chi phí lợi nhuận ước tính
    case getEstimatedRevenueCostProfitReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //Báo cáo nguyên liệu
    case getMaterialReport(material_category_id:Int, report_type:Int ,from_date:String, to_date:String, date_string:String)
    //Báo cáo doanh thu chi phí lợi nhuận thực tế
    case getActualRevenueCostProfitReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //Báo cáo tổng quan
    case getSupplierGeneralReport(restaurant_brand_id:Int, branch_id:Int, report_type:Int, date_string:String, from_date:String, to_date:String)
    case UpdatePriceList(materialsId:String,price:Int,restaurant_id:Int)
    //=== QUAN LY KHACH HANG ===//
    case getlistRestaurant(status:Int,limit:Int,page:Int,key_search:String)
    case getListBranchesCustomer(status:Int,restaurant_id:Int,restaurant_brand_id:Int,limit:Int,page:Int,key_search:String)
    case getDetailRestaurantReport(restaurantId:Int)

    case getListBrandsCustomer(restaunrant_id:Int,limit:Int,page:Int,status:Int,key_search:String)
    //=== QUAN LY THIET LAP TAI KHOAN ===//
    case ChangePassword(oldPassword:String,new_password:String)
    case sendFeedBack(name:String, email:String, phone:String, project_id:String, type:Int, describe:String)
    case resetPassword(IdEmployee:Int)
    
    
    //================================ pham khanh huy ===========================
    //Báo cáo đơn hàng
    case getOrderReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //Báo cáo kho
    case getInventoryReport(material_category_id:Int,report_type:Int, date_string: String, from_date: String, to_date: String)
    //Báo cáo trả huỷ mặt hàng
    case getCancelItemReport(report_type:Int,type:Int,date_string: String, from_date: String, to_date: String)
    //Báo cáo công nợ
    case getDebtReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //Báo cáo Đơn hàng theo nhà Hàng
    case getRestaurantOrderReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //báo cáo Mặt hàng
    case getItemReport(report_type:Int, date_string: String, from_date: String, to_date: String)
    //báo cáo danh mục
    case getCategoryReport(material_category_id:Int,report_type:Int, date_string: String, from_date: String, to_date: String)
    
    //API lấy danh sách mặt hàng
    case getMaterialList(status:Int, key_search:String,limit:Int, page:Int)
    case getAllCategoryMaterial(status: Int)
    case getAllMaterialMeasureUnits
    //API update trạng thái của material
    case postChangMaterialStatus(id:Int)
    //API tạo mặt hàng
    case postCreateMaterial(material:Material)
    //API update mặt hàng
    case postUpdateMaterial(material:Material)
    
    
    
    //API lấy danh sách thu chi
    case getReceiptAndPaymentList(type:Int, status:Int,from_date:String, to_date:String, key_search:String, limit:Int = 500, page:Int = 1)
    //API lấy chi tiết phiếu thu chi
    case getReceiptAndPaymentDetail(id:Int)
    //API lấy chi tiết kho theo id
    case getSupplierWarehouseSession(status:Int, type:Int, payment_status:String, limit:Int, page:Int, key_search:String, from_date:String, to_date:String)
    //Lấy thông tin chi tiết đơn hang
    case getOrderDetail(id:Int, status:Int, is_return_material:Int,page:Int = 1, limit:Int = 500)
    
    
    //API lấy danh sách hạng mục thu chi
    case getReceiptAndPaymentCategory(supplier_addition_fee_reason_category_id:Int,supplier_addition_fee_type:Int,is_hidden:Int,
                                      key_search:String,is_system_auto_generate:Int)
    //API lấy danh sách LOẠI hạng mục thu chi
    case getReceiptAndPaymentCategoryType(supplier_addition_fee_type:Int, is_hidden:Int, is_system_auto_generate:Int)
    //API thay đổi trạng thái của hạng mục thu chi
    case postChangeReceiptAndPaymentCategoryStatus(id:Int)
    //API tạo hạng mục thu chi
    case postCreateReceiptAndPaymentCategory(name:String, supplier_addition_fee_reason_category_id:Int, supplier_addition_fee_type:Int)
    //API cập nhật hạng mục thu chi
    case postUpdateReceiptAndPaymentCategory(id:Int,name:String)
    
    
    //API tạo phiếu thu chi
    case postCreateReceiptAndPayment(note:String, amount:Double = 0.0, warehouse_session_ids:[Int], object_type:Int, fee_month:String, supplier_addition_fee_reason_id:Int)
    //API thay đổi trạng thái của phiếu thu chi
    case postChangReceiptAndPaymentStatus(id:Int,status:Int, reason:String)
    //API sửa phiếu thu chi của nhà cung cấp
    case postUpdateReceiptAndPayment(receiptPayment: ReceiptPayment)
    // cập nhật thông tin nhân viên
    case postUpdateEmployeeProfile(avatar:String,name:String,identity_card:String,gender:Int, phone:String,birthDate:String, email:String,address:String,city_id:Int, district_id:Int, ward_id:Int,supplier_role_id:Int)
    // API lấy danh sách quy cách quy đổi
    case getMaterialUnitSpecifications(status:Int)
    //API chỉnh sửa trạng thái quy cách quy đổi
    case postChangeMaterialUnitSpecsStatus(id:Int)
    //API chỉnh sửa quy cách quy đổi
    case postUpdateMaterialUnitSpecs(id:Int,name:String, exchange_value:Int)
    //API thêm quy cách quy đổi
    case postCreateMaterialUnitSpecs(assign_to_unit_id:Int, material_unit_specification_exchange_name_id:Int, name:String, exchange_value:Int)
    //API lấy danh sách đơn vị quy đổi
    case getExchangeUnitSpecsList
    
    //API lấy danh sách dơn vị
    case getMaterialUnitList(status:Int)
    //API thay đổi trạng thái dơn vị
    case postChangeMaterialUnitStatus(id:Int)
    //API cập nhật đơn vị
    case postUpdateMaterialUnit(id:Int,name:String, description:String, specification_ids:[Int])
    //API thêm đơn vị
    case postCreateMaterialUnit(name:String, code:String, description:String, unit_specifications:[Int])
    
    
    
    //lay danh sach loai hinh kinh doanh
    case getListTypesBusiness
    
    
    
    // ================== QUANG HUY DEFINE =================
    // ================== SUPPLIER ORDERS =================
    case getSupplierOrders(restaurant_id:Int, brand_id:Int, branch_id:Int, payment_status:String, status:String, key_search:String, from_date:String, to_date:String, is_return_material:Int, is_return_all_total_material:Int, limit:Int, page:Int)
    
    case getSupplierOrdersRequest(restaurant_id: Int, restaurant_brand_id: Int, branch_id: Int, from_date: String, to_date: String, status: String, key_search:String, limit:Int, page:Int)
    case getDetailSupplierOrdersRequest(id: Int, limit:Int, page:Int)
    case getDetailSupplierOrders(id: Int, status: String, limit:Int, page:Int)
    case getSupplierOrdersRequestGroupByRestaurant(from_date: String, to_date: String, key_search:String, status: String, payment_status:String, limit:Int, page:Int)
    case getSupplierOrdersGroupByRestaurant(from_date: String, to_date: String, key_search:String, status: String, payment_status:String, limit:Int, page:Int)
    case postSupplierOrdersConfirm(vat: Float, restaurant_material_order_request_id: Int, supplier_order_request_id: Int, expected_delivery_time: String, discount_percent: Float, discount_amount: Int, list_material: [ListMaterialResquest])
    case postSupplierOrdersChangeStatus(id: Int, status: Int, reason: String, supplier_warehouse_session_type: Int)
    case postSupplierOrdersRequestChangeStatus(id: Int, status: Int, reason: String)
    case postSupplierWarehouseSessionsCreate(type: Int, discount_percent: Int, discount_amount: Int, vat_percent: Int, note: String, material_datas: [SupplierMaterialOrderRequest])
    case postSupplierWarehouseSessionsCreateCancel(type: Int, note: String, material_datas: [SupplierMaterialOrderRequest])

    
    // ========== API SUPPLIER DEBT MANAGEMENT ==========
    case getSupplierDebtPayment(restaurant_id:Int, restaurant_brand_id:Int, branch_id:Int, status:String, from_date:String, to_date:String, key_search:String, is_delete:Int, limit:Int, page:Int)
    case getDetailSupplierDebtPayment(id:Int)
    case getSupplierDebtPaymentChangeStatus(id:Int, status: Int)
    case postSupplierDebtPaymentCreate(restaurant_id: Int, branch_id: Int, status: Int, from_date:String, to_date:String, supplier_order_ids: [Int])
    case postSupplierDebtPaymentUpdate(id: Int, restaurant_id: Int, branch_id: Int, status: Int, from_date:String, to_date:String, insert_supplier_order_ids: [Int], delete_supplier_order_ids: [Int])
    
    
    // ========== API INVENTORY MANAGEMENT ==========
    case getSupplierWarehouseSessions(status:String, type:String, payment_status:String, limit:Int, page:Int, key_search:String, from_date:String, to_date:String)
    case getDetailSupplierWarehouseSessions(id:Int)
    case getSupplierWarehouseSessionsDetail(id:Int, limit:Int, page:Int)
    case getSupplierWarehouseSessionsChangeStatus(id:Int, status: Int, reason: String, supplier_warehouse_session_type: Int)
    case postSupplierWarehouseSessionsUpdate(id: Int, discount_percent: Int, discount_amount: Int, vat_percent: Int, note: String, material_datas: [SupplierMaterialOrderRequest])

    // ================== END QUANG HUY DEFINE =================
    
    
    case getSupplierMaterials(Supplier_id:Int,key_search:String)
    
    case getSupplierOrdersByIds(supplier_order_ids:String)
    
}

extension ManagerConections {
    
    var baseURL: URL {
        return URL(string: APIEndPoint.endPointURL)!
    }
    
    var path: String {
        switch self {
        case .sessions:
            return APIEndPoint.Name.urlSessions
            
        case .config(_):
            return APIEndPoint.Name.urlConfig
            
        case .registerDevice:
            return APIEndPoint.Name.urlRegisterDevice
            
        case .login(_, _, _):
            return APIEndPoint.Name.urlLogin
        case .setting:
            return APIEndPoint.Name.urlSetting
            
            
            
            
        case .getMaterialReport(_,_,_,_,_):
            return APIEndPoint.Name.urlGetMaterialReport
        case .getEstimatedRevenueCostProfitReport(_,_,_,_):
            return APIEndPoint.Name.urlGetEstimatedRevenueCostProfitReport
        case .getActualRevenueCostProfitReport(_,_,_,_):
            return APIEndPoint.Name.urlGetActualRevenueCostProfitReport
        case .getSupplierGeneralReport(_,_,_,_,_,_):
            return APIEndPoint.Name.urlSupplierGeneralReport

            //    === Tien Dung Management Employee ==== start
        case .employees(let status,let key_search,let limit,let page):
            return APIEndPoint.Name.urlListEmployee // lẤY DANH SÁCH NHÂN VIÊN
        case .employeInfo(let employeeId):
            return String(format:APIEndPoint.Name.urlInfoEmployee, employeeId) // lẤY THÔNG TIN NHÂN VIÊN
        case .employeeLock(let id):
            return String(format:APIEndPoint.Name.urlLockEmployee, id) // kHOÁ HOẶC MỞ KHOÁ NHÂN VIÊN
        case .employeeUpdateInfo(let id,_):
            return String(format: APIEndPoint.Name.urlUpdateInfoEmployee, id)
        case .getsupplierroles:
            return APIEndPoint.Name.urlListRoleEmployee
        case .cities:
            return APIEndPoint.Name.urlCities
        case .districts(_, _):
            let parameter = parameters! as NSDictionary
            let city_id = parameter.object(forKey: "city_id") as? Int
            
            return String(format: APIEndPoint.Name.urlDistrict, city_id!)
            
        case .wards(_, _):
            let parameter = parameters! as NSDictionary
            let district_id = parameter.object(forKey: "district_id") as? Int

            return String(format: APIEndPoint.Name.urlWards, district_id!)
        case .createEmployee(_):
            return APIEndPoint.Name.urlCreateEmployee
        case .generateFileNameResource(_):
            
            return APIEndPoint.Name.urlGenerateLink
        // == Tien dung get supplier =====
        case .getListSupplier(_):
            return APIEndPoint.Name.urlRestaurantsMap
        case .getSupplierMaterials(let SupplierId,let key_search):
            return String(format: APIEndPoint.Name.urlSupplierMaterials, SupplierId)
        case .UpdatePriceList(let materialsId,_,_):
            return String(format: APIEndPoint.Name.urlUpdatePriceList, materialsId)
        // === tien dung - get list restaurant ===//
        case .getlistRestaurant(let status,let limit,let page,let key_search):
            return APIEndPoint.Name.urlGetListRestaurant
        case .getListBranchesCustomer(let status,let restaurant_id,let restaurant_brand_id, let limit, let page,let key_search):
            return APIEndPoint.Name.urlGetDetailRestaurant
        case .getDetailRestaurantReport(let restaurantId):
            return String(format: APIEndPoint.Name.urlGetDetailRestaurantReport,restaurantId)

        case .getListBrandsCustomer(let restaunrant_id,let limit,let page,let status,let key_search):

            return APIEndPoint.Name.urlGetListBrand
        case .getSupplierInfo:
            return APIEndPoint.Name.urlSupplierInfo
        case .updateSupplierInfoBusiness(_,_,_,_,_,_,_,_,_,_,_,_,_,_):
            return APIEndPoint.Name.urlUpdateSupplierInfo
        case .getListSupplierDebtPayment(let from_date,let to_date,let status,let payment_status):
            return APIEndPoint.Name.urlSupplierOrders
        case .getListSupplierWarehouseSessions(_,_,_,_,_):
            return APIEndPoint.Name.urlSupplierWarehouseSessions
        // === Tien dung - change password ===
        case .ChangePassword(_,_):
            return String(format: APIEndPoint.Name.urlChangePassword,ManageCacheObject.getCurrentUser().id)
        case .sendFeedBack(_,_,_,_,_,_):
            return APIEndPoint.Name.urlSendFeedBack
        case .resetPassword(let IdEmployee):
            return String(format: APIEndPoint.Name.urlResetPassword,IdEmployee)
        case .forgotPassword(_):
            return APIEndPoint.Name.urlForgotPassword
        case .verifyChangePassword(_,_,_,_,_,_):
            return APIEndPoint.Name.urlVerifyChangePassword
        case .verifyCode(_,_,_):
            return APIEndPoint.Name.urlVerifyCode
        //=====
        case .getOrderReport(_,_,_,_):
            return APIEndPoint.Name.urlGetOrderReport
        case .getInventoryReport(_,_,_,_,_):
            return APIEndPoint.Name.urlGetInventoryReport
        case .getCancelItemReport(_,_,_,_,_):
            return APIEndPoint.Name.urlGetCancelItemReport
        case .getDebtReport(_,_,_,_):
            return APIEndPoint.Name.urlGetDebtReport
        case .getRestaurantOrderReport(_,_,_,_):
            return APIEndPoint.Name.urlGetRestaurantOrderReport
        case .getItemReport(_,_,_,_):
            return APIEndPoint.Name.urlGetItemReport
        case .getCategoryReport(_,_,_,_,_):
            return APIEndPoint.Name.urlGetCategoryReport
        
            
        case .getMaterialList(_,_,_,_):
            return APIEndPoint.Name.urlGetMaterialList
        case .getAllCategoryMaterial(_):
            return APIEndPoint.Name.urlGetAllCategoryMaterial
        case .getAllMaterialMeasureUnits:
            return APIEndPoint.Name.urlGetAllMaterialMeasureUnits
        case .postChangMaterialStatus(let id):
            return String(format: APIEndPoint.Name.urlPostChangMaterialStatus, id)
        case .postCreateMaterial(_):
            return APIEndPoint.Name.urlPostCreateMaterial
        case .postUpdateMaterial(let material):
            return String(format: APIEndPoint.Name.urlPostUpdateMaterial, material.id)
            
        case .getReceiptAndPaymentList(_,_,_,_,_,_,_):
            return APIEndPoint.Name.urlGetReceiptAndPaymentList
        case .getReceiptAndPaymentDetail(let id):
            return String(format: APIEndPoint.Name.urlGetReceiptAndPaymentDetail, id)
        case .getSupplierWarehouseSession(_,_,_,_,_,_,_,_):
            return APIEndPoint.Name.urlGetSupplierWarehouseSession
        case .getOrderDetail(let id,_,_,_,_):
            return String(format: APIEndPoint.Name.urlGetOrderDetail, id)
        
        //API lấy danh sách hạng mục thu chi
        case .getReceiptAndPaymentCategory(_,_,_,_,_):
            return APIEndPoint.Name.urlGetReceiptAndPaymentCategory
        case .getReceiptAndPaymentCategoryType(_,_,_):
            return APIEndPoint.Name.urlGetReceiptAndPaymentCategoryType
        case .postCreateReceiptAndPaymentCategory(_,_,_):
            return APIEndPoint.Name.urlPostCreateReceiptAndPaymentCategory
        case .postChangeReceiptAndPaymentCategoryStatus(let id):
            return String(format: APIEndPoint.Name.urlPostChangeReceiptAndPaymentCategoryStatus, id)
        case .postUpdateReceiptAndPaymentCategory(let id,_):
            return String(format: APIEndPoint.Name.urlPostUpdateReceiptAndPaymentCategory, id)
            
            
        case .postCreateReceiptAndPayment(_,_,_,_,_,_):
            return APIEndPoint.Name.urlPostCreateReceiptAndPayment
        case .postChangReceiptAndPaymentStatus(let id,_,_):
            return String(format: APIEndPoint.Name.urlPostChangReceiptAndPaymentStatus, id)
        case .postUpdateReceiptAndPayment(let receiptPayment):
            return APIEndPoint.Name.urlGetMaterialUnitSpecifications
        case .postUpdateEmployeeProfile(_,_,_,_,_,_,_,_,_,_,_,_):
            return String(format: APIEndPoint.Name.urlUpdateInfoEmployee,ManageCacheObject.getCurrentUser().employee_id)
    
       
        case .getMaterialUnitSpecifications(_):
            return APIEndPoint.Name.urlGetMaterialUnitSpecifications
        case .postChangeMaterialUnitSpecsStatus(let id):
            return String(format: APIEndPoint.Name.urlPostChangeMaterialUnitSpecsStatus, id)
        case .postUpdateMaterialUnitSpecs(let id,_,_):
            return String(format: APIEndPoint.Name.urlPostUpdateMaterialUnitSpecs,id)
        case .postCreateMaterialUnitSpecs(_,_,_,_):
            return APIEndPoint.Name.urlPostCreateMaterialUnitSpecs
        case .getExchangeUnitSpecsList:
            return APIEndPoint.Name.urlGetExchangeUnitSpecsList
           
        case .getMaterialUnitList(_):
            return APIEndPoint.Name.urlGetMaterialUnitList
        case .postChangeMaterialUnitStatus(let id):
            return String(format: APIEndPoint.Name.urlPostChangeMaterialUnitStatus, id)
        case .postUpdateMaterialUnit(let id,_,_,_):
            return String(format: APIEndPoint.Name.urlPostUpdateMaterialUnit,id)
        case .postCreateMaterialUnit(_,_,_,_):
            return APIEndPoint.Name.urlPostCreateMaterialUnit
       
            
    
            
            
        case .notifications(type: let type, is_viewed: let is_viewed, page: let page, limit: let limit):
            return APIEndPoint.Name.urlNotification
        case .getSupplierOrders(_, _, _, _, _, _, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierOrders
        case .getSupplierOrdersRequestGroupByRestaurant(_,_,_,_,_,_,_):
            return APIEndPoint.Name.urlSupplierOrdersRequestGroupByRestaurant
        case .getSupplierOrdersGroupByRestaurant(_, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierOrdersGroupByRestaurant
        case .getSupplierOrdersRequest(_, _, _, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierOrdersRequest
        case .getDetailSupplierOrdersRequest(let id, _, _):
            return String(format: APIEndPoint.Name.urlDetailSupplierOrdersRequest, id)
        case .getDetailSupplierOrders(let id, _, _, _):
            return String(format: APIEndPoint.Name.urlDetailSupplierOrders, id)
        case .postSupplierOrdersConfirm(_, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierOrdersConfirm
        case .postSupplierOrdersChangeStatus(let id, _, _, _):
            return String(format: APIEndPoint.Name.urlSupplierOrdersChangeStatus, id)
        case .postSupplierOrdersRequestChangeStatus(let id, _, _):
            return String(format: APIEndPoint.Name.urlSupplierOrdersRequestChangeStatus, id)
        case .postSupplierWarehouseSessionsCreate(_, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierWarehouseSessionsCreate
        case .postSupplierWarehouseSessionsCreateCancel(_, _, _):
            return APIEndPoint.Name.urlSupplierWarehouseSessionsCreateCancel
            
        case .getSupplierDebtPayment(_, _, _, _, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierDebtPayment
        case .getDetailSupplierDebtPayment(let id):
            return String(format: APIEndPoint.Name.urlDetailSupplierDebtPayment, id)
        case .getSupplierDebtPaymentChangeStatus(let id, _):
            return String(format: APIEndPoint.Name.urlSupplierDebtPaymentChangeStatus, id)
        case .postSupplierDebtPaymentCreate(_, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierDebtPaymentCreate
        case .postSupplierDebtPaymentUpdate(let id, _, _, _, _, _, _, _):
            return String(format: APIEndPoint.Name.urlSupplierDebtPaymentUpdate, id)
        case .getSupplierWarehouseSessions(_, _, _, _, _, _, _, _):
            return APIEndPoint.Name.urlSupplierWarehouseSessions
        case .getDetailSupplierWarehouseSessions(let id):
            return String(format: APIEndPoint.Name.urlDetailSupplierWarehouseSessions, id)
        case .getSupplierWarehouseSessionsChangeStatus(let id, _, _, _):
            return String(format: APIEndPoint.Name.urlSupplierWarehouseSessionsChangeStatus, id)
        case .postSupplierWarehouseSessionsUpdate(let id, _, _, _, _, _):
            return String(format: APIEndPoint.Name.urlSupplierWarehouseSessionsUpdate, id)
        case .getSupplierWarehouseSessionsDetail(_, _, _):
            return APIEndPoint.Name.urlSupplierWarehouseSessionsDetail
            
        case .getSupplierOrdersByIds(_):
            return APIEndPoint.Name.urlGetSupplierOrdersByIds
            
        case .getListTypesBusiness:
            return APIEndPoint.Name.urlGetListTypesBusiness
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sessions:
            return .get
        case .config(_):
            return .get
        case .registerDevice:
            return .post
        case .login(_, _, _):
            return .post
        case .setting:
            return .get

            //    === Tien Dung Management Employee ==== start
        case .employees(_,_,_,_):
            return .get
        case .employeInfo(_):
            return .get
        case .employeeLock(_):
            return .post
        case .employeeUpdateInfo(_,_):
            return .post
        case .getsupplierroles:
            return .get
        case .cities(_):
            return .get
        case .districts(_,_):
            return .get
        case .wards(_,_):
            return .get
        case .createEmployee(_):
            return .post
        case .generateFileNameResource(_):
            return .post
        case .getListSupplier(_):
            return .get
        case .getSupplierMaterials(_,_):
            return .get
        case .UpdatePriceList(_,_,_):
            return .post
        case .getSupplierInfo:
            return .get
        case .updateSupplierInfoBusiness(_,_,_,_,_,_,_,_,_,_,_,_,_,_):
            return .post
        case .getListSupplierDebtPayment(_,_,_,_):
            return .get
        case .getListSupplierWarehouseSessions(_,_,_,_,_):
            return .get
       // ==== tien dung === end
            
        // === tien dung get list restaurant === //
        case .getlistRestaurant(_,_,_,_):
            return .get
        case .getListBranchesCustomer(_,_,_,_,_,_):
            return .get
        case .getDetailRestaurantReport(_):
            return .get

        case .getListBrandsCustomer(_,_,_,_,_):
            return .get
        // tien dung change password
        case .ChangePassword(_,_):
            return .post
        case .sendFeedBack(_,_,_,_,_,_):
            return .post
        case .resetPassword(_):
            return .post
        case .forgotPassword(_):
            return .post
        case .verifyChangePassword(_,_,_,_,_,_):
            return .post
        case .verifyCode(_,_,_):
            return .post
        // ====
            
            
        case .notifications(type: let type, is_viewed: let is_viewed, page: let page, limit: let limit):
            return .get

            
        case .getMaterialReport(_,_,_,_,_):
            return .get
        case .getEstimatedRevenueCostProfitReport(_,_,_,_):
            return .get
      
        case .getActualRevenueCostProfitReport(_,_,_,_):
            return .get
        case .getSupplierGeneralReport(_,_,_,_,_,_):
            return .get
            
        case .getOrderReport(_,_,_,_):
            return .get
        case .getInventoryReport(_,_,_,_,_):
            return .get
        case .getCancelItemReport(_,_,_,_,_):
            return .get
        case .getDebtReport(_,_,_,_):
            return .get
        case .getRestaurantOrderReport(_,_,_,_):
            return .get
        case .getItemReport(_,_,_,_):
            return .get
        case .getCategoryReport(_,_,_,_,_):
            return .get
        

            
        case .getMaterialList(_,_,_,_):
            return .get
        case .getAllCategoryMaterial(_):
            return .get
        case .getAllMaterialMeasureUnits:
            return .get
        case .postChangMaterialStatus(_):
            return .post
        case .postCreateMaterial(_):
            return .post
        case .postUpdateMaterial(_):
            return .post
        
        case .getReceiptAndPaymentList(_,_,_,_,_,_,_):
            return .get
        case .getReceiptAndPaymentDetail(_):
            return .get
        case .getSupplierWarehouseSession(_,_,_,_,_,_,_,_):
            return .get
        case .getOrderDetail(let id,_,_,_,_):
            return .get
            
            
        case .getReceiptAndPaymentCategory(_,_,_,_,_):
            return .get
        case .getReceiptAndPaymentCategoryType(_,_,_):
            return .get
        case .postCreateReceiptAndPaymentCategory(_,_,_):
            return .post
        case .postChangeReceiptAndPaymentCategoryStatus(_):
            return .post
        case .postUpdateReceiptAndPaymentCategory(_,_):
            return .post

            
            
            
            
        case .postCreateReceiptAndPayment(_,_,_,_,_,_):
            return .post
        case .postChangReceiptAndPaymentStatus(_,_,_):
            return .post
        case .postUpdateReceiptAndPayment(_):
            return .post
        case .postUpdateEmployeeProfile(_,_,_,_,_,_,_,_,_,_,_,_):
            return .post
        
        case .getMaterialUnitSpecifications(_):
            return .get
        case .postChangeMaterialUnitSpecsStatus(_):
            return .post
        case .postUpdateMaterialUnitSpecs(_,_,_):
            return .post
        case .postCreateMaterialUnitSpecs(_,_,_,_):
            return .post
            
        case .getMaterialUnitList(_):
            return .get
        case .postChangeMaterialUnitStatus(_):
            return .post
        case .postUpdateMaterialUnit(_,_,_,_):
            return .post
        case .postCreateMaterialUnit(_,_,_,_):
            return .post
        case .getExchangeUnitSpecsList:
            return .get
            
            
            
        case .getSupplierOrders(_, _, _, _, _, _, _, _, _, _, _, _):
            return .get
        case .getSupplierOrdersRequestGroupByRestaurant(_,_,_,_,_,_,_):
            return .get
        case .getSupplierOrdersGroupByRestaurant(_, _, _, _, _, _, _):
            return .get
        case .getSupplierOrdersRequest(_, _, _, _, _, _, _, _, _):
            return .get
        case .getDetailSupplierOrdersRequest(_, _, _):
            return .get
        case .getDetailSupplierOrders(_, _, _, _):
            return .get
        case .postSupplierOrdersConfirm(_, _, _, _, _, _, _):
            return .post
        case .postSupplierOrdersChangeStatus(_, _, _, _):
            return .post
        case .postSupplierOrdersRequestChangeStatus(_, _, _):
            return .post
        case .postSupplierWarehouseSessionsCreate(_, _, _, _, _, _):
            return .post
        case .postSupplierWarehouseSessionsCreateCancel(_, _, _):
            return .post
            
        case .getSupplierDebtPayment(_, _, _, _, _, _, _, _, _, _):
            return .get
        case .getDetailSupplierDebtPayment(_):
            return .get
        case .getSupplierDebtPaymentChangeStatus(_, _):
            return .post
        case .postSupplierDebtPaymentCreate(_, _, _, _, _, _):
            return .post
        case .postSupplierDebtPaymentUpdate(_, _, _, _, _, _, _, _):
            return .post
        case .getSupplierWarehouseSessions(_, _, _, _, _, _, _, _):
            return .get
        case .getDetailSupplierWarehouseSessions(_):
            return .get
        case .getSupplierWarehouseSessionsChangeStatus(_, _, _, _):
            return .post
        case .postSupplierWarehouseSessionsUpdate(_, _, _, _, _, _):
            return .post
        case .getSupplierWarehouseSessionsDetail(_, _, _):
            return .get
            
        case .getSupplierOrdersByIds(_):
            return .get
        case .getListTypesBusiness:
            return .get

        }
    }
    
    
    func headerJava(ProjectId:Int = Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method:Int = Constants.METHOD_TYPE.GET) -> [String : String]{
        if  ManageCacheObject.isLogin(){
            return ["Authorization": String(format: "Bearer %@", ManageCacheObject.getCurrentUser().access_token), "ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
        }else{
            if ManageCacheObject.getConfig().api_key != nil{
                return ["Authorization": String(format: "Basic %@", ManageCacheObject.getConfig().api_key), "ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
            }else{
                return ["ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
            }
            
        }
    }
    
    func headerNode(ProjectId:Int = Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method:Int = Constants.METHOD_TYPE.GET) -> [String : String]{
        if  ManageCacheObject.isLogin(){
            return ["Authorization": String(format: "Bearer %@", ManageCacheObject.getCurrentUser().access_token), "ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
        }else{
            return ["Authorization": String(format: "%@", ManageCacheObject.getConfig().api_key), "ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
            
        }
    }
    
    
    
    var headers: [String : String]? {
        switch self {
        case .sessions:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.GET)
            
        case .config(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.GET)
            
        case .registerDevice:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.POST)
            
        case .login(_, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.POST)
            
        case .setting:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.GET)
            
            //    === Tien Dung Management Employee ==== start
        case .employees(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER,Method: Constants.METHOD_TYPE.GET)
        case .employeInfo(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER,Method: Constants.METHOD_TYPE.GET)
        case .employeeLock(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .employeeUpdateInfo(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getsupplierroles:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .cities(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .districts(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .wards(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .createEmployee(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .generateFileNameResource(_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_UPLOAD_SERVICE, Method: Constants.METHOD_TYPE.POST)
        case .getListSupplier(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getSupplierMaterials(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .UpdatePriceList(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getSupplierInfo:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .updateSupplierInfoBusiness(_,_,_,_,_,_,_,_,_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getListSupplierDebtPayment(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getListSupplierWarehouseSessions(_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            // === tien dung === end
            // === tien dung get list restaurant ===//

        case .getlistRestaurant(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getListBranchesCustomer(_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getDetailRestaurantReport(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            
        case .getListBrandsCustomer(_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            // === tien dung setting account ===//
        case .ChangePassword(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .forgotPassword(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.POST)
        case .verifyChangePassword(_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.POST)
        case .verifyCode(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_OAUTH, Method: Constants.METHOD_TYPE.POST)
            //====

        case .sendFeedBack(_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .resetPassword(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
      //====
            
            
        case .getMaterialReport(_,_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
        case .getEstimatedRevenueCostProfitReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
    
            
        case .getActualRevenueCostProfitReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getSupplierGeneralReport(_,_,_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getOrderReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getInventoryReport(_,_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getCancelItemReport(_,_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getDebtReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getRestaurantOrderReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getItemReport(_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
        case .getCategoryReport(_,_,_,_,_):
            return headerNode(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_REPORT, Method: Constants.METHOD_TYPE.GET)
            
            
        case .getMaterialList(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getAllCategoryMaterial(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getAllMaterialMeasureUnits:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .postChangMaterialStatus(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postCreateMaterial(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateMaterial(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
            
        case .getReceiptAndPaymentList(_,_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getReceiptAndPaymentDetail(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getSupplierWarehouseSession(_,_,_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getOrderDetail(_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            
            
        case .getReceiptAndPaymentCategory(_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .getReceiptAndPaymentCategoryType(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .postCreateReceiptAndPaymentCategory(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postChangeReceiptAndPaymentCategoryStatus(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateReceiptAndPaymentCategory(_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
            
            
            
        case .postCreateReceiptAndPayment(_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postChangReceiptAndPaymentStatus(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateReceiptAndPayment(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateEmployeeProfile(_,_,_,_,_,_,_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER,Method: Constants.METHOD_TYPE.POST)
            
            
        case .getMaterialUnitSpecifications(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .postChangeMaterialUnitSpecsStatus(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateMaterialUnitSpecs(_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postCreateMaterialUnitSpecs(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getExchangeUnitSpecsList:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            
        case .getMaterialUnitList(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
        case .postChangeMaterialUnitStatus(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postUpdateMaterialUnit(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postCreateMaterialUnit(_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
            
            
        case .notifications(type: let type, is_viewed: let is_viewed, page: let page, limit: let limit):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.GET)
            
        case .getSupplierOrders(_, _, _, _, _, _, _, _, _, _, _, _):
            
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierOrdersRequestGroupByRestaurant(_,_,_,_,_,_,_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierOrdersGroupByRestaurant(_, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierOrdersRequest(_, _, _, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getDetailSupplierOrdersRequest(_, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getDetailSupplierOrders(_, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .postSupplierOrdersConfirm(_, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierOrdersChangeStatus(_, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierOrdersRequestChangeStatus(_, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierWarehouseSessionsCreate(_, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierWarehouseSessionsCreateCancel(_, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getSupplierDebtPayment(_, _, _, _, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getDetailSupplierDebtPayment(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierDebtPaymentChangeStatus(_, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierDebtPaymentCreate(_, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierDebtPaymentUpdate(_, _, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getSupplierWarehouseSessions(_, _, _, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getDetailSupplierWarehouseSessions(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierWarehouseSessionsChangeStatus(_, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .postSupplierWarehouseSessionsUpdate(_, _, _, _, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER, Method: Constants.METHOD_TYPE.POST)
        case .getSupplierWarehouseSessionsDetail(_, _, _):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getSupplierOrdersByIds(_):
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        case .getListTypesBusiness:
            return headerJava(ProjectId: Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER)
        
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .sessions:
            return ["device_uid":Utils.getUDID()]
        case .config(let supplier_name):
            return ["project_id": Constants.apiKey, "device_uid": Utils.getUDID(), "supplier_name":supplier_name]
            
        case .registerDevice:
            return [ "device_uid":Utils.getUDID(),
                     "os_name":"tms_ios",
                     "employee_id":ManageCacheObject.getCurrentUser().id,
                     "push_token":ManageCacheObject.getPushToken()]
            
        case .login(let supplier_name, let username, let password):
            return ["supplier_name":supplier_name, "username": username, "password": Utils.encoded(str: password), "device_uid":Utils.getUDID(), "app_type":Utils.getAppType(), "push_token": ManageCacheObject.getPushToken()]
            
        
        case .setting:
            return [:]
            //    === Tien Dung Management Employee ==== start
        case .employees(let status,let key_search,let limit, let page):
            return  ["status":status,
                     "key_search":key_search,
                     "limit":limit,
                     "page":page
            ]
        case .employeInfo(_):
            return [:]
        case .employeeLock(_):
            return [:]
        case .employeeUpdateInfo(_,let DetailEmployee):
            return ["name": DetailEmployee.name,
                    "email": DetailEmployee.email,
                    "phone": DetailEmployee.phone,
                    "address": DetailEmployee.address,
                    "avatar": DetailEmployee.avatar,
                    "supplier_role_id": DetailEmployee.supplier_role_id,
                    "birthday": DetailEmployee.birthday,
                    "gender": DetailEmployee.gender,
                    "identity_card": DetailEmployee.identity_card,
                    "city_id": DetailEmployee.city_id,
                    "district_id": DetailEmployee.district_id,
                    "ward_id": DetailEmployee.ward_id
            ]
        case .getsupplierroles:
            return [:]
        case .cities(let limit):
            return ["limit":limit, "country_id": ACTIVE]
        case .districts(let city_id, let limit):
            return ["city_id": city_id, "limit":limit]

        case .wards(let district_id, let limit):
            return ["district_id": district_id, "limit": limit]
        case .createEmployee(let DetailEmployeeNew):
            return [
                "name": DetailEmployeeNew.name,
                "email": DetailEmployeeNew.email,
                "phone": DetailEmployeeNew.phone,
                "address": DetailEmployeeNew.address,
                "avatar": DetailEmployeeNew.avatar,
                "supplier_role_id": DetailEmployeeNew.supplier_role_id,
                "birthday": DetailEmployeeNew.birthday,
                "gender": DetailEmployeeNew.gender,
                "identity_card": DetailEmployeeNew.identity_card,
                "city_id": DetailEmployeeNew.city_id,
                "district_id": DetailEmployeeNew.district_id,
                "ward_id": DetailEmployeeNew.ward_id
            ]
        case .generateFileNameResource(let medias):
            return ["medias": medias.toJSON()]
        case .getListSupplier(let key_search):
            return ["key_search":key_search]

//        case .getSupplierMaterials(_):
//            return [:]
        case .UpdatePriceList(_,let price,let restaurant_id):
            return [
                   "price": price,
                   "restaurant_id": restaurant_id
            ]
        case .getSupplierInfo:
            return [:]
        case .updateSupplierInfoBusiness(let name,let email,let phone, let address,let tax_code,let website,let description,let avatar,let information,let city_id,let district_id,let ward_id,let cover_photo,let supplier_business_type_id):
            return [
                "name": name,
                  "email": email,
                  "phone": phone,
                  "address": address,
                  "tax_code": tax_code,
                  "website": website,
                  "description": description,
                  "avatar": avatar,
                "information": information,
                  "city_id": city_id,
                  "district_id": district_id,
                  "ward_id": ward_id,
                "cover_photo":cover_photo,
                "supplier_business_type_ids": supplier_business_type_id
            ]
        case .getListSupplierDebtPayment(let from_date,let  to_date,let status,let payment_status):
            return [
                "from_date":from_date,
                "to_date": to_date,
                "status": status,
                "payment_status":payment_status
            ]
        case .getListSupplierWarehouseSessions(let from_date,let to_date,let type, let status,let payment_status):
            return [
                "from_date": from_date,
                "to_date": to_date,
                "type": type,
                "status": status,
                "payment_status": payment_status
            ]
        // === tien dung === end
        // === tien dung get list restaurant ===
        case .getlistRestaurant(let status,let limit,let page,let key_search):
            return [
                "status": status,
                "limit": limit,
                "page": page,
                "key_search": key_search
                   ]
        case .getListBranchesCustomer(let status,let restaurant_id,let restaurant_brand_id,let limit,let page,let key_search):
            return [
                "status":status,
                "restaurant_id":restaurant_id,
                "restaurant_brand_id":restaurant_brand_id,
                "limit":limit,
                "page":page,
                "key_search":key_search
            ]
        case .getDetailRestaurantReport(_):
            return [:]

        case .getListBrandsCustomer(let restaunrant_id,let limit,let page,let status,let key_search):
            return [
                  "restaurant_id":restaunrant_id,
                  "limit":limit,
                  "page":page,
                  "status":status,
                  "key_search":key_search
            ]
    //=== Tien dung setting account ===//
        case .ChangePassword(let oldPassword, let new_password):
            return [
                "old_password": Utils.encoded(str: oldPassword),
                "new_password" :Utils.encoded(str: new_password),
            ]
        case .sendFeedBack(let name,let email,let phone,let project_id, let type, let describe):
            return [
                "name":name,
                "email":email,
                "phone":phone,
                "project_id":project_id,
                "type":type,
                "content":describe
            ]
        case .resetPassword(_):
            return [:]
        case .forgotPassword(let username):
            return ["username": username]
        case .verifyChangePassword(let username, let verify_code, let new_password, let node_access_token, let device_uid, let app_type):
            return [
                "username": username,
                "verify_code": verify_code,
                "new_password" :Utils.encoded(str: new_password),
                "node_access_token": node_access_token,
                "device_uid": device_uid,
                "app_type": app_type
            ]
        case .verifyCode(let supplier_name,let user_name,let verify_code):
            return [
                "supplier_name": supplier_name,
                "username": user_name,
                "verify_code" :verify_code
            ]
        //===
        case .notifications(type: let type, is_viewed: let is_viewed, page: let page, limit: let limit):
            return ["type":type, "is_viewed": is_viewed, "page": page, "limit":limit]
            
            
            
        case .getMaterialReport(let material_category_id, let report_type, let from_date, let to_date, let date_string):
            return ["material_category_id":material_category_id, "report_type": report_type, "from_date":from_date, "to_date":to_date, "date_string":date_string]
            
        case .getEstimatedRevenueCostProfitReport(let report_type, let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
          
        case .getActualRevenueCostProfitReport(let report_type,let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getSupplierGeneralReport(let restaurant_brand_id, let branch_id, let report_type, let date_string, let from_date, let to_date):
            return ["restaurant_brand_id":restaurant_brand_id, "branch_id": branch_id, "report_type": report_type, "date_string":date_string, "from_date":from_date, "to_date":to_date]
            
            
          
        case .getOrderReport(let report_type, let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
          
        case .getInventoryReport(let material_category_id,let report_type, let date_string, let from_date, let to_date):
            return ["material_category_id":material_category_id,"report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getCancelItemReport(let report_type,let type, let date_string, let from_date, let to_date):
            return ["report_type":report_type,"type":type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getDebtReport(let report_type, let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getRestaurantOrderReport(let report_type, let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getItemReport(let report_type, let date_string, let from_date, let to_date):
            return ["report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        case .getCategoryReport(let material_category_id, let report_type, let date_string, let from_date, let to_date):
            return ["material_category_id":material_category_id,"report_type":report_type, "date_string": date_string, "from_date": from_date, "to_date":to_date]
            
        //API lấy danh sách mặt hàng
        case .getMaterialList(let status, let key_search ,let limit, let page):
            return ["status":status,"key_search":key_search,"limit":limit,"page":page]
            
        case .getAllCategoryMaterial(let status):
            return ["status":status]
        case .getAllMaterialMeasureUnits:
            return [:]
        //API update trạng thái của material
        case .postChangMaterialStatus(let id):
            return [:]
        //API tạo mặt hàng
        case .postCreateMaterial(let material):
            return [
                "code": material.code,
                "name":  material.name,
                "material_unit_id": material.material_unit_id,
                "material_unit_specification_id":  material.material_unit_specification_id,
                "material_category_id": material.material_category_id,
                "avatar": material.avatar,
                "avatar_thumb": material.avatar_thumb,
                "cost_price": material.price,
                "wholesale_price": material.wholesale_price,
                "retail_price": material.retail_price,
                "wholesale_price_quantity": material.wholesale_price_quantity,
                "out_stock_alert_quantity": material.out_stock_alert_quantity,
                "wastage_rate": material.wastage_rate,
                "status": material.status
            ]
        //API update mặt hàng
        case .postUpdateMaterial(let material):
            return [
                "code": material.code,
                "name": material.name,
                "materialUnitSpecExVal": material.material_unit_specification_exchange_value,
                "status": material.status,
                "description": material.description,
                "material_unit_id": material.material_unit_id,
                "material_unit_specification_id": material.material_unit_specification_id,
                "material_category_id": material.material_category_id,
                "avatar": material.avatar,
                "avatar_thumb": material.avatar_thumb,
                "cost_price": material.price,
                "wholesale_price": material.wholesale_price_quantity,
                "retail_price":  material.retail_price,
                "wholesale_price_quantity": material.wholesale_price,
                "out_stock_alert_quantity": material.out_stock_alert_quantity,
                "wastage_rate":  material.wastage_rate
            ]
            
            
            
        case .getReceiptAndPaymentList(let type, let status, let from_date, let to_date, let key_search, let limit, let page):
            return [
                "type":type,
                "status":status,
                "from_date":from_date,
                "to_date":to_date,
                "key_search":key_search,
                "limit":limit,
                "page":page
            ]
            

        case .getReceiptAndPaymentDetail(_):
            return [:]
        case .getSupplierWarehouseSession(let status, let type, let payment_status, let limit, let page, let key_search, let from_date, let to_date):
            return [
               "status":status,
               "type":type,
               "payment_status":payment_status,
               "limit":limit,
               "page":page,
               "key_search":key_search,
               "from_date":from_date,
               "to_date":to_date
            ]
            
        case .getOrderDetail(let id, let status, let is_return_material, let page, let limit):
            return [
                "id":id,
                "status":status,
                "is_return_material":is_return_material,
                "page":page,
                "limit":limit
            ]
            
            
            
            
            
          
       
        case .getReceiptAndPaymentCategory(let supplier_addition_fee_reason_category_id, let supplier_addition_fee_type, let is_hidden,
                                           let key_search,let is_system_auto_generate):
            return [
//                    "supplier_addition_fee_reason_category_id":supplier_addition_fee_reason_category_id,
                    "supplier_addition_fee_type":supplier_addition_fee_type,
                    "is_hidden":is_hidden,
                    "key_search":key_search,
                    "is_system_auto_generate":is_system_auto_generate]
            
        case .getReceiptAndPaymentCategoryType(let supplier_addition_fee_type, let is_hidden, let is_system_auto_generate):
            return [
                "supplier_addition_fee_type":supplier_addition_fee_type,
                "is_hidden":is_hidden,
                "is_system_auto_generate":is_system_auto_generate
            ]
        case .postCreateReceiptAndPaymentCategory(let name, let supplier_addition_fee_reason_category_id, let supplier_addition_fee_type):
            return [
                "name":name,
                "supplier_addition_fee_reason_category_id":supplier_addition_fee_reason_category_id,
                "supplier_addition_fee_type":supplier_addition_fee_type
            ]
        case .postChangeReceiptAndPaymentCategoryStatus(_):
            return [:]
            
        case .postUpdateReceiptAndPaymentCategory(_,let name):
            return ["name":name]
            
            
            
            
        case .postCreateReceiptAndPayment(let note,let  amount, let warehouse_session_ids,let object_type,let  fee_month,let  supplier_addition_fee_reason_id):
            return [
                "amount": amount,
                "note": note,
                "supplier_addition_fee_reason_id": supplier_addition_fee_reason_id,
                "object_type": object_type,
                "fee_month": fee_month,
                "warehouse_session_ids": warehouse_session_ids,
            ]
           
        case .postChangReceiptAndPaymentStatus(_, let status, let reason):
            return [
                "status": status,
                "reason": reason
            ]
            
        case .postUpdateReceiptAndPayment(let receiptPayment):
            return [
                "amount": receiptPayment.amount,
                "note": receiptPayment.note,
                "supplier_addition_fee_reason_id": receiptPayment.supplier_addition_fee_reason_id,
                "fee_month": receiptPayment.fee_month
            ]
            
        case .postUpdateEmployeeProfile(let avatar, let name, let identity_card, let gender , let phone, let birthDate, let email, let address, let city_id, let district_id, let ward_id,let supplier_role_id):
            return [
                "avatar": avatar,
                "name": name,
                "identity_card": identity_card,
                "gender": gender,
                "phone": phone,
                "birthday": birthDate,
                "email": email,
                "address": address,
                "city_id": city_id,
                "district_id": district_id,
                "ward_id": ward_id,
                "node_access_token": ManageCacheObject.getCurrentUser().jwt_token,
                "supplier_role_id": supplier_role_id

            ]
        

        case .getMaterialUnitSpecifications(let status):
            return ["status":status]
   
        case .postChangeMaterialUnitSpecsStatus(_):
            return [:]
            
          
        case .postUpdateMaterialUnitSpecs(let id, let name, let exchange_value):
            return ["id":id,"name":name,"exchange_value":exchange_value]
      
        case .postCreateMaterialUnitSpecs(let assign_to_unit_id, let material_unit_specification_exchange_name_id, let name, let exchange_value):
            return ["assign_to_unit_id":assign_to_unit_id,"name":name,"exchange_value":exchange_value, "material_unit_specification_exchange_name_id":material_unit_specification_exchange_name_id]
        case .getExchangeUnitSpecsList:
            return [:]
       
        case .getMaterialUnitList(let status):
            return ["status":status]
       
        case .postChangeMaterialUnitStatus(_):
            return [:]
       
        case .postUpdateMaterialUnit(let id, let name, let description, let specification_ids):
            return ["name":name,"description":description, "specification_ids":specification_ids]
       
        case .postCreateMaterialUnit(let name, let code, let description, let unit_specifications):
            return ["name":name,"code":code, "description":description,"unit_specifications":unit_specifications]
            
            
        case .getSupplierMaterials(_,let key_search):
            return ["key_search":key_search]
             
    
            

        case .getSupplierOrders(let restaurant_id, let brand_id, let branch_id, let payment_status, let status, let key_search, let from_date, let to_date, let is_return_material, let is_return_all_total_material, let limit, let page):
            return [ "restaurant_id": restaurant_id,
                     "brand_id": brand_id,
                     "branch_id": branch_id,
                     "payment_status": payment_status,
                     "status": status,
                     "key_search": key_search,
                     "from_date": from_date,
                     "to_date": to_date,
                     "is_return_material": is_return_material,
                     "is_return_all_total_material": is_return_all_total_material,
                     "limit": limit,
                     "page": page]
        case .getSupplierOrdersRequestGroupByRestaurant(let from_date, let to_date, let key_search, let status, let payment_status,let limit, let page):
            return [ "from_date": from_date,
                     "to_date":to_date,
                     "key_search":key_search,
                     "status": status,
                     "payment_status": payment_status,
                     "limit": limit,
                     "page": page
            ]
        case .getSupplierOrdersGroupByRestaurant(let from_date, let to_date, let key_search, let status, let payment_status,let limit, let page):
            return [ "from_date": from_date,
                     "to_date":to_date,
                     "key_search":key_search,
                     "status": status,
                     "payment_status": payment_status,
                     "limit": limit,
                     "page": page]
        case .getSupplierOrdersRequest(let restaurant_id, let restaurant_brand_id, let branch_id, let from_date, let to_date, let status, let key_search, let limit, let page):
            return [
                    "restaurant_id": restaurant_id,
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                     "from_date":from_date,
                     "to_date":to_date,
                     "status":status,
                     "key_search":key_search,
                     "limit":limit,
                     "page": page]
        case .getDetailSupplierOrdersRequest(let id, let limit, let page):
            return [ "id": id,
                     "limit":limit,
                     "page":page]
        case .getDetailSupplierOrders(let id, let status, let limit, let page):
            return ["id": id,
                    "status": status,
                    "limit":limit,
                    "page":page]
        case .postSupplierOrdersConfirm(let vat, let restaurant_material_order_request_id, let supplier_order_request_id, let expected_delivery_time, let discount_percent, let discount_amount, let list_material):
            return [ "vat": vat,
                     "restaurant_material_order_request_id": restaurant_material_order_request_id,
                     "supplier_order_request_id": supplier_order_request_id,
                     "expected_delivery_time": expected_delivery_time,
                     "discount_percent": discount_percent,
                     "discount_amount": discount_amount,
                     "list_material": list_material.toJSON()]
        case .postSupplierOrdersChangeStatus(let id, let status, let reason, let supplier_warehouse_session_type):
            return ["id": id,
                    "status": status,
                    "reason":reason,
                    "supplier_warehouse_session_type":supplier_warehouse_session_type]
        case .postSupplierOrdersRequestChangeStatus(let id, let status, let reason):
            return ["id": id,
                    "status": status,
                    "reason":reason]
        case .postSupplierWarehouseSessionsCreate(let type, let discount_percent, let discount_amount, let vat_percent, let note, let material_datas):
            return [ "type": type,
                     "discount_percent": discount_percent,
                     "discount_amount": discount_amount,
                     "vat_percent": vat_percent,
                     "note": note,
                     "material_datas": material_datas.toJSON()]
        case .postSupplierWarehouseSessionsCreateCancel(let type, let note, let material_datas):
            return ["type": type,
                    "note": note,
                    "material_datas": material_datas]
        case .getSupplierDebtPayment(let restaurant_id, let restaurant_brand_id, let branch_id, let status, let from_date, let to_date, let key_search, let is_delete, let limit, let page):
            return [ "restaurant_id": restaurant_id,
                     "restaurant_brand_id": restaurant_brand_id,
                     "branch_id": branch_id,
                     "status": status,
                     "from_date": from_date,
                     "to_date": to_date,
                     "key_search": key_search,
                     "is_delete": is_delete,
                     "limit": limit,
                     "page": page]
        case .getDetailSupplierDebtPayment(let id):
            return [ "id": id]
        case .getSupplierDebtPaymentChangeStatus(let id, let status):
            return ["id": id,
                    "status": status]
        case .postSupplierDebtPaymentCreate(let restaurant_id, let branch_id, let status, let from_date, let to_date, let supplier_order_ids):
            return ["restaurant_id": restaurant_id,
                    "branch_id": branch_id,
                    "status": status,
                    "from_date": from_date,
                    "to_date": to_date,
                    "supplier_order_ids":supplier_order_ids]
        case .postSupplierDebtPaymentUpdate(let id, let restaurant_id, let branch_id, let status, let from_date, let to_date, let insert_supplier_order_ids, let delete_supplier_order_ids):
            return ["id": id,
                    "restaurant_id": restaurant_id,
                    "branch_id": branch_id,
                    "status": status,
                    "from_date": from_date,
                    "to_date": to_date,
                    "insert_supplier_order_ids": insert_supplier_order_ids,
                    "delete_supplier_order_ids": delete_supplier_order_ids]
        case .getSupplierWarehouseSessions(let status, let type, let payment_status, let limit, let page, let key_search, let from_date, let to_date):
            return ["status": status,
                    "type": type,
                    "payment_status": payment_status,
                    "limit": limit,
                    "page": page,
                    "key_search": key_search,
                    "from_date": from_date,
                    "to_date": to_date]

        case .getDetailSupplierWarehouseSessions(let id):
            return ["id": id]
        case .getSupplierWarehouseSessionsChangeStatus(let id, let status, let reason, let supplier_warehouse_session_type):
            return ["id": id,
                    "status": status,
                    "reason": reason,
                    "supplier_warehouse_session_type": supplier_warehouse_session_type]
        case .postSupplierWarehouseSessionsUpdate(let id, let discount_percent, let discount_amount, let vat_percent, let note, let material_datas):
            return [ "id": id,
                     "discount_percent": discount_percent,
                     "discount_amount": discount_amount,
                     "vat_percent": vat_percent,
                     "note": note,
                     "material_datas": material_datas.toJSON()]
            
        case .getSupplierWarehouseSessionsDetail(let id, let limit, let page):
            return ["id": id,
                    "limit": limit,
                    "page": page]
            
        case .getSupplierOrdersByIds(let supplier_order_ids):
            return ["supplier_order_ids": supplier_order_ids]
        case .getListTypesBusiness:
            return [:]
        
        }
        
    }
    
    /// The parameter encoding. `URLEncoding.default` by default.
    private func encoding(_ httpMethod: HTTPMethod) -> ParameterEncoding {
        var encoding : ParameterEncoding = JSONEncoding.default
        if httpMethod == .get{
            encoding = URLEncoding.default
        }
        return encoding
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var task: Task {
        dLog(headers ?? "")
        switch self {
        case .sessions:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            
        case .config(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            
        case .registerDevice:
       
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
            
        case .login(_, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .setting:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            //    === Tien Dung Management Employee ==== start
        case .employees(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .employeInfo(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .employeeLock(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .employeeUpdateInfo(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getsupplierroles:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .cities:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .districts(_, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .wards(_, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .createEmployee(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .generateFileNameResource(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListSupplier:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierMaterials(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .UpdatePriceList(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getSupplierInfo:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .updateSupplierInfoBusiness(_,_,_,_,_,_,_,_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListSupplierDebtPayment(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListSupplierWarehouseSessions(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .ChangePassword(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .sendFeedBack(_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .resetPassword(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .forgotPassword(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .verifyChangePassword(_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .verifyCode(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .notifications(type: let type, is_viewed: let is_viewed, page: let page, limit: let limit):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))

            
        case .getMaterialReport(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getEstimatedRevenueCostProfitReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getActualRevenueCostProfitReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierGeneralReport(_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        
        case .getOrderReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getInventoryReport(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getCancelItemReport(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDebtReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getRestaurantOrderReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getItemReport(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getCategoryReport(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getMaterialList(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getAllCategoryMaterial(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getAllMaterialMeasureUnits:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postChangMaterialStatus(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postCreateMaterial(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateMaterial(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
         
        case .getReceiptAndPaymentList(_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getReceiptAndPaymentDetail(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierWarehouseSession(_,_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getOrderDetail(let id, let status, let is_return_material, let page, let limit):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        
            
        case .getReceiptAndPaymentCategory(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getReceiptAndPaymentCategoryType(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postCreateReceiptAndPaymentCategory(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postChangeReceiptAndPaymentCategoryStatus(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateReceiptAndPaymentCategory(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
            
            
            
            
            
            
        case .postCreateReceiptAndPayment(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postChangReceiptAndPaymentStatus(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateReceiptAndPayment(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateEmployeeProfile(_,_,_,_,_,_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
            
        case .getMaterialUnitSpecifications(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postChangeMaterialUnitSpecsStatus(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateMaterialUnitSpecs(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postCreateMaterialUnitSpecs(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getExchangeUnitSpecsList:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            
        case .getMaterialUnitList(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postChangeMaterialUnitStatus(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postUpdateMaterialUnit(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postCreateMaterialUnit(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
            
            
        case .getSupplierOrders(_, _, _, _, _, _, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierOrdersRequestGroupByRestaurant(_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierOrdersGroupByRestaurant(_, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierOrdersRequest(_, _, _, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDetailSupplierOrdersRequest(_, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDetailSupplierOrders(_, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postSupplierOrdersConfirm(_, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierOrdersChangeStatus(_, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierOrdersRequestChangeStatus(_, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierWarehouseSessionsCreate(_, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
            
            
            
            //=== tien dung get list restaurant ===
        case .getlistRestaurant(_, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListBranchesCustomer(_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDetailRestaurantReport(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))

        case .getListBrandsCustomer(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            //===
        case .getSupplierDebtPayment(_, _, _, _, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDetailSupplierDebtPayment(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierDebtPaymentChangeStatus(_, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierDebtPaymentCreate(_, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierDebtPaymentUpdate(_, _, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getSupplierWarehouseSessions(_, _, _, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getDetailSupplierWarehouseSessions(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getSupplierWarehouseSessionsChangeStatus(_, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .postSupplierWarehouseSessionsUpdate(_, _, _, _, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getSupplierWarehouseSessionsDetail(_, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
            
        case .getSupplierOrdersByIds(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListTypesBusiness:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postSupplierWarehouseSessionsCreateCancel(_, _, _):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))

        }
    }
    
}
let apiManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 20
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.urlCache = nil
        let manager = Alamofire.Session(
            configuration: configuration,
            cachedResponseHandler:  ResponseCacher(behavior: .doNotCache)
        )
        return manager
    }()

  
    let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions:.requestBody)
    let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)

    
    let endpointClosure = { (target: ManagerConections) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
    }
    
  

    let appServiceProvider = MoyaProvider<ManagerConections>(endpointClosure: endpointClosure,
                                                             plugins: [networkLogger, NetworkActivityPlugin(networkActivityClosure: { (activity, target) in
        switch activity
        {
        case .began:
            print("Network Activity began")
           
            DispatchQueue.main.async {
                if let visibleViewCtrl = UIApplication.shared.keyWindow?.rootViewController {
                    // do whatever you want with your `visibleViewCtrl`
                    print(visibleViewCtrl)
                    JHProgressHUD.sharedHUD.showInView(visibleViewCtrl.view)
                }
            }
            
            
            
            
        case .ended:
            print("Network Activity ended")
            DispatchQueue.main.async {
                if let visibleViewCtrl = UIApplication.shared.keyWindow?.rootViewController {
                    // do whatever you want with your `visibleViewCtrl`
                    JHProgressHUD.sharedHUD.hide()
                }
            }
        }
        
    })])
