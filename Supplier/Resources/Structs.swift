//
//  Structs.swift
//  Supplier
//
//  Created by kelvin on 12/07/2023.
//


import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public struct APIEndPoint {
    
    static let endPointURL = Environment.develop.rawValue
    
    static let enviromentMod = EnvironmentMode.develop.rawValue
    
    
    //============ JAVA SERVICE ===============
    private static let version = "v5"
    private static let version_inventory = "v3"
    private static let version_report_service = "v1"
    private static let version_oauth = "v5"
    //============ upload service =============
    private static let version_upload_service = "v2"
    
    private enum Environment:String {

        case develop = "https://beta.api.gateway.overate-vntech.com"
        case staging = "http://172.16.2.242:8092/api/queues"
        case production = "https://api.gateway.overate-vntecch.com"
    }
    
    private enum EnvironmentMode:Int {
        case develop = 0
        case staging = 2
        case production = 1
    }
    
    struct  ORDER_STATUS {
        static let order_status_proccessing = "0,1,3,4,6"
        static let order_status_completed = "2,5,7"
    }
    struct  ORDER_STATUS_ENUM {
        static let  COMPLETED = 2
        static let  WAITING_PAYMENT = 4
        static let  DEBT_BILL = 5
        static let  WAITING_COMFIRED = 6
    }
    
   
    
    
    
    struct Name {
        static let urlSessions = String(format: "/api/%@/sessions", version_oauth)
        static let urlConfig = "/api/\(version_oauth)/configs"
        static let urlRegisterDevice = String(format: "/api/%@/register-device", version_oauth)
        static let urlLogin = "/api/\(version_oauth)/suppliers/login"
        static let urlSetting = String(format: "/api/%@/suppliers/settings", version_oauth)

        //.   === Tien Dung Setting Account.    ====
        static let urlChangePassword = "/api/\(version)/employees/%d/change-password"
        static let urlSendFeedBack = "/api/\(version)/employees/feedback"
        static let urlResetPassword = "/api/\(version)/employees/%d/reset-password"
        //    === Tien Dung Management Employee ====
        static let urlLockEmployee = "/api/\(version)/employees/%d/change-status" // khoá tài khoản nhân viên
        static let urlInfoEmployee = "/api/\(version)/employees/%d" // lấy thông tin nhân viên
        static let urlListRoleEmployee = "/api/\(version)/supplier-roles" // Lấy danh sách quyền của nhân viên
        static let urlUnLockEmployee = "/api/\(version)/employees/%d/change-status" // mở khoá tài khoản nhân viên
        static let urlListEmployee = "/api/\(version)/employees" // lấy danh sách nhân viên
        static let urlUpdateInfoEmployee = "/api/\(version)/employees/%d" // Cập nhật thông tin nhân viên
        static let urlCities = String(format: "/api/%@/administrative-units/cities",version )
        static let urlDistrict = String(format: "/api/%@/administrative-units/districts",version )
        static let urlWards = String(format: "/api/%@/administrative-units/wards",version )
        static let urlCreateEmployee = "/api/\(version)/employees/create"
        static let urlGenerateLink = "/api/\(version_upload_service)/media/generate"
        // == tien dung Management Price list ===
        static let urlRestaurantsMap = "/api/\(version)/restaurants/restaurants-map"
        static let urlSupplierMaterials = "/api/\(version)/materials/%d/supplier-materials-restaurant-using"
        static let urlNotification = String(format: "/api/%@/suppliers/notification", version_oauth)

        
        static let urlGetMaterialReport = String(format: "/api/%@/supplier-warehouse-material-report", version_report_service)
        static let urlGetEstimatedRevenueCostProfitReport = String(format: "/api/%@/supplier-revenue-cost-profit-estimated-report", version_report_service)
        static let urlGetActualRevenueCostProfitReport = String(format: "/api/%@/supplier-revenue-report-by-time", version_report_service)
        static let urlSupplierGeneralReport = String(format: "/api/%@/supplier-overview-report", version_report_service)
        static let urlUpdatePriceList = "/api/\(version)/materials/%@/supplier-material-price"
        static let urlSupplierInfo = "/api/\(version)/suppliers" // lay thong tin doanh nghiep
        static let urlUpdateSupplierInfo = "/api/\(version)/suppliers/update" // cap nhat thong tin doanh nghiep
        static let urlGetListTypesBusiness = "/api/v5/suppliers/supplier-business-types" // lay danh sach loai hinh kinh doanh
        // ========== QUANG HUY DEFINE ==========
        // ========== API SUPPLIER ORDERS ==========
        static let urlSupplierOrders = "/api/\(version)/supplier-orders" // API lấy danh sách đơn hàng
        static let urlDetailSupplierOrdersRequest = "/api/\(version)/supplier-order-request/%d/supplier-order-request-detail" //API Lấy danh chi tiết nguyên liệu theo phiếu yêu cầu của kế toán
        static let urlDetailSupplierOrders = "/api/\(version)/supplier-orders/%d/supplier-order-detail" // API lấy chi tiết thông tin đơn hàng
        static let urlSupplierOrdersRequest = "/api/\(version)/supplier-order-request" // API Lấy danh sách phiếu yêu cầu từ kế toán lên nhà cung cấp
        static let urlSupplierOrdersRequestGroupByRestaurant = "/api/\(version)/supplier-order-request/group-by-restaurant" // API Gom nhóm đơn hàng theo nhà hàng
        static let urlSupplierOrdersGroupByRestaurant = "/api/\(version)/supplier-orders/group-by-restaurant" // API Nhà cung cấp lấy danh sách đơn hàng được nhóm lại theo từng nhà hàng
        static let urlSupplierOrdersConfirm = "/api/\(version)/supplier-orders/confirm" // API xác nhận đơn hàng từ nhà hàng gửi lên
        static let urlSupplierOrdersChangeStatus = "/api/\(version)/supplier-orders/%d/change-status" // API khi xác nhận hoặc hủy một phiếu sẽ đổi trạng thái
        static let urlSupplierOrdersRequestChangeStatus = "/api/\(version)/supplier-order-request/%d/change-status" // API khi xác nhận hoặc hủy một phiếu sẽ đổi trạng thái
        static let urlSupplierWarehouseSessionsCreate = "/api/\(version)/supplier-warehouse-sessions/create" // API tạo phiếu kho cho nhà cung cấp
        static let urlSupplierWarehouseSessionsCreateCancel = "/api/\(version)/supplier-warehouse-sessions/create-cancel" // API tạo phiếu huỷ kho cho nhà cung cấp

        // ========== API SUPPLIER DEBT MANAGEMENT ==========
        static let urlSupplierDebtPayment = "/api/\(version)/supplier-restaurant-debt-payment-requests" // API lấy danh sách Phiếu nợ
        static let urlDetailSupplierDebtPayment = "/api/\(version)/supplier-restaurant-debt-payment-requests/%d" // API lấy chi tiết Phiếu nhắc nợ
        static let urlSupplierDebtPaymentCreate = "/api/\(version)/supplier-restaurant-debt-payment-requests/create" // API tạo phiếu yêu cầu thanh toán
        static let urlSupplierDebtPaymentUpdate = "/api/\(version)/supplier-restaurant-debt-payment-requests/%d/update" // API chỉnh sửa phiếu yêu cầu thanh toán
        static let urlSupplierDebtPaymentChangeStatus = "/api/\(version)/supplier-restaurant-debt-payment-requests/%d/change-status" // API thay đổi trạng thái phiếu yêu cầu thanh toán
       
        // ========== API SUPPLIER WAREHOUSE SESSIONS MANAGEMENT ==========
        static let urlSupplierWarehouseSessions = "/api/\(version)/supplier-warehouse-sessions" // API lấy danh sách phiếu kho nhà cung cấp
        static let urlDetailSupplierWarehouseSessions = "/api/\(version)/supplier-warehouse-sessions/%d" // API lấy chi tiết phiếu kho nhà cung cấp
        static let urlSupplierWarehouseSessionsDetail = "/api/\(version)/supplier-warehouse-sessions/details" // API lấy chi tiết kho nhà cung cấp
        static let urlSupplierWarehouseSessionsChangeStatus = "/api/\(version)/supplier-warehouse-sessions/%d/change-status" // API thay đổi trạng thái phiếu kho
        static let urlSupplierWarehouseSessionsUpdate = "/api/\(version)/supplier-warehouse-sessions/%d/update" // API chỉnh sửa phiếu kho ncc

        // ========== END QUANG HUY DEFINE ==========
        


        static let urlGetOrderReport = String(format: "/api/%@/supplier-order-list-report", version_report_service)
        static let urlGetCancelItemReport = String(format: "/api/%@/supplier-material-cancel-return-report", version_report_service)
        static let urlGetInventoryReport = String(format: "/api/%@/supplier-warehouse-sesssion-report", version_report_service)
        static let urlGetDebtReport = String(format: "/api/%@/supplier-debt-report", version_report_service)
        static let urlGetRestaurantOrderReport = String(format: "/api/%@/supplier_order_by_customer", version_report_service)
        static let urlGetItemReport = String(format: "/api/%@/supplier-overview-report", version_report_service)
        static let urlGetCategoryReport = String(format: "/api/%@/supplier-category-detail", version_report_service)
        
        static let urlGetMaterialList = "/api/\(version)/materials"
        static let urlGetAllCategoryMaterial = "/api/\(version)/material-categories"
        static let urlGetAllMaterialMeasureUnits = "/api/\(version)/material-units"
        static let urlPostChangMaterialStatus = "/api/\(version)/materials/%d/change-status"
        static let urlPostCreateMaterial = "/api/\(version)/materials/create"
        static let urlPostUpdateMaterial = "/api/\(version)/materials/%d/update"
        static let urlPostUpdateEmployeeProfile = "/api/\(version)/employees/%d/update"

        static let urlGetReceiptAndPaymentList = "/api/\(version)/supplier-addition-fees"
        static let urlGetReceiptAndPaymentDetail = "/api/\(version)/supplier-addition-fees/%d"
        static let urlGetSupplierWarehouseSession = "/api/\(version)/supplier-warehouse-sessions"
        static let urlGetOrderDetail = "/api/\(version)/supplier-orders/%d/supplier-order-detail"
        
        static let urlGetReceiptAndPaymentCategory = "/api/\(version)/supplier-addition-fee-reasons"
        static let urlGetReceiptAndPaymentCategoryType = "/api/\(version)/supplier-addition-fee-reasons/addition-fee-reason-categories"
        static let urlPostCreateReceiptAndPaymentCategory = "/api/\(version)/supplier-addition-fee-reasons/create"
        static let urlPostChangeReceiptAndPaymentCategoryStatus = "/api/\(version)/supplier-addition-fee-reasons/%d/change-hidden"
        static let urlPostUpdateReceiptAndPaymentCategory = "/api/\(version)/supplier-addition-fee-reasons/%d/update"
            
        
        
        
        static let urlPostCreateReceiptAndPayment = "/api/\(version)/supplier-addition-fees/create"
        static let urlPostChangReceiptAndPaymentStatus = "/api/\(version)/supplier-addition-fees/%d/change-status"
        static let urlPostUpdateReceiptAndPayment = "/api/\(version)/supplier-addition-fees/%d"
        static let urlGetMaterialUnitSpecifications = "/api/\(version)/supplier-material-unit-specifications"
        static let urlPostChangeMaterialUnitSpecsStatus = "/api/\(version)/supplier-material-unit-specifications/%d/change-status"
        static let urlPostUpdateMaterialUnitSpecs = "/api/\(version)/supplier-material-unit-specifications/%d"
        static let urlPostCreateMaterialUnitSpecs = "/api/\(version)/supplier-material-unit-specifications/create"
        static let urlGetExchangeUnitSpecsList = "/api/\(version)/material-unit-specification-exchange-name"
        static let urlGetMaterialUnitList = "/api/\(version)/material-units"
        static let urlPostChangeMaterialUnitStatus = "/api/\(version)/material-units/%d/change-status"
        static let urlPostUpdateMaterialUnit = "/api/\(version)/material-units/%d"
        static let urlPostCreateMaterialUnit = "/api/\(version)/material-units/create"
        
        //===Tien Dung QUAN LY KHACH HANG ===//
        static let urlGetListRestaurant = "/api/\(version)/restaurants"
        static let urlGetDetailRestaurant = "/api/\(version)/branches"
        static let urlGetDetailRestaurantReport = "/api/\(version)/restaurants/supplier-restaurant-detail/%d"
        static let urlGetListBrand = "/api/\(version)/restaurant-brand"
        //===Tien Dung quen mat khau ===//
        static let urlForgotPassword = "/api/\(version)/suppliers/forgot-password"
        static let urlVerifyChangePassword = "/api/\(version)/suppliers/verify-change-password"
        static let urlVerifyCode = "/api/\(version)/suppliers/verify-code"
        static let urlGetSupplierOrdersByIds = "/api/\(version)/supplier-orders/by-ids"
    }

    
    
    struct SOCKET_GATEWAY {
        static let CHAT_DOMAIN = "http://techres.ddns.net:9013"
    }
    
   
}

enum RRSortEnum: Int {
    case asc
    case desc

    var title: String? {
        switch self {
        case .asc:
            return "Ascending"
        case .desc:
            return "Descending"
        }
    }
}
