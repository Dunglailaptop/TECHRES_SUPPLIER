//
//  Constants.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit

struct Constants {
    static let apiKey = "net.techres.supplier.api"
    static let OS_NAME = "iOS"
    
    static let OK = "OK"
    
    struct MESSAGE {
        static let OK = "OK"
    }
    struct AUTHORIZATION_KEYS{
        static let AUTHORIZATION =  "Authorization"
        static let AUTHORIZATION_BASIC_TYPE =  "Basic"
        static let AUTHORIZATION_BEARER_TYPE =  "Bearer"
    }
    struct PARAMS_KEY{
        static let  REQUEST_URL = "request_url"
        static let  PROJECT_ID = "project_id"
        static let  HTTP_METHOD = "http_method"
        static let  PRODUCT_MODE = "is_production_mode"
        static let  PARAMS = "params"
        static let OS_NAME = "os_name"
        
    }
    
    struct PROJECT_IDS {
          static let PROJECT_OAUTH = 8888 // oauth java api
          static let PROJECT_ID_SEEMT = 8093

          static let PROJECT_ID_SUPPLIER = 8087
          static let PROJECT_ID_INVENTORY = 8095
          static let PROJECT_ID_SALE_SMALL = 8197
          static let PROJECT_ID_ORDER = 8094
          static let PROJECT_ID_REPORT = 1457
          static let PROJECT_ID_UPLOAD = 9007
          static let PROJECT_ID_KAIZEN = 7029
     
        static let PROJECT_UPLOAD_SERVICE = 9007
      }

    
    struct METHOD_TYPE {
        static let GET = 0
        static let POST = 1
    }
    
    struct METHOD_TYPE_STRING {
        static let POST = "POST"
        static let GET = "GET"
    }
    
    
    struct ENVIRONMENT_MODE {
        static let ENVIRONMENT_MODE = 0// 0: develop, 1: production
    }
    
    struct STATUS_CODES {
        static let UNAUTHORIZED = 401
        static let SUCCESS = 200
        static let NOT_FOUND = 404
        static let BAD_REQUEST = 400
    }
    
    
    struct CONFIG_LINKS {
        static let LINK_POLICY = "https://techres.vn/chinh-sach-bao-mat/"
        static let LINK_PRIVACY = "http://techres.vn/quy-dinh-su-dung/"
    }




    //CONFIG STAGING
//    #define GETWAY_SERVER_URL @"http://172.16.10.72:8892/api/queues"
//    #define CHAT_DOMAIN @"http://172.16.10.82:1483"
//    #define REALTIME_SERVER_URL @"http://172.16.10.71:1483"
//    #define UPLOAD_DOMAIN @"https://172.16.10.85"
//    #define DEFAULT_MAIN_DOMAIN @"https://beta.api.order.techres.vn"
//
    
    //    LIVE
    //        struct URL {
//                static let GETWAY_SERVER_URL = "https://api.gateway.techres.vn/api/queues"
//                static let CHAT_DOMAIN = "http://api.realtime.techres.vn:1483"
//                static let REALTIME_SERVER_URL = "http://api.realtime.techres.vn:1483"
//                static let UPLOAD_DOMAIN = "https://storage.aloapp.vn"
    //
    //        }
        
        //BETA
        struct URL {
            static let GETWAY_SERVER_URL = "http://172.16.2.243:8092/api/queues"
            static let CHAT_DOMAIN = "http://172.16.2.240:1483"
            static let REALTIME_SERVER_URL = "http://172.16.2.240:1483"
            static let UPLOAD_DOMAIN = "https://beta.storage.aloapp.vn"
        }
        
        struct Endpoints {
            static let urlConfig = "/api/configs"
            static let urlLogin = "/api/customers/login"
            static let urlCreateBooking = "/api/v2/bookings/create"
            static let urlBookings = "/api/v2/bookings"
           
            
            static let urlCreateAccount = "api/ver2/customers/register"
            static let urlOtp = "/api/ver2/customers/verify-code"
            static let urlSendOtp = "/api/ver2/customers/send-verify-code"
            static let urlUpdateInfo = "/api/ver2/customers/update-profile-register"
            
            static let groupChat = "/api/groups?limit=%d&page=%d"
            static let friendOnline = "/api/friends/online?limit=%d&page=%d"
            
            static let order = "/api/customers/\(ManageCacheObject.getCurrentUser().access_token)/orders"
        }

        
        struct KEY_DEFAULT_STORAGE{
            static let KEY_ACCOUNT = "KEY_ACCOUNT"
            static let KEY_SETTING = "KEY_SETTING"
            static let KEY_ACCOUNT_ID = "KEY_ACCOUNT_ID"
            static let KEY_TOKEN = "KEY_TOKEN"
            static let KEY_PUSH_TOKEN = "KEY_PUSH_TOKEN"
            static let KEY_CONFIG = "KEY_CONFIG"
            static let KEY_APP_LANGUAGE = "APP_LANGUAGE"
            static let KEY_PHONE = "KEY_PHONE"
            static let KEY_PASSWORD = "KEY_PASSWORD"
            static let KEY_BIOMETRIC = "KEY_BIOMETRIC"
            static let KEY_LOGIN = "KEY_LOGIN"
            static let KEY_LOCATION = "KEY_LOCATION"
            static let KEY_PERMISION_CONTACT = "KEY_PERMISION_CONTACT"
            static let KEY_TIME = "KEY_TIME"
            static let KEY_ACCOUNT_NODE = "KEY_ACCOUNT_NODE"
            static let KEY_TAB_INDEX = "KEY_TAB_INDEX"
            static let KEY_NUMBER_UNREAD_MESSAGE = "KEY_NUMBER_UNREAD_MESSAGE"
            static let KEY_BRANCH = "KEY_BRANCH"
            static let KEY_BRAND = "KEY_BRAND"
            static let KEY_PLAY_SOUND = "KEY_PLAY_SOUND"
            static let KEY_SUPPLIER_NAME = "KEY_SUPPLIER_NAME"
            static let KEY_USERNAME = "KEY_USERNAME"

            
        }
        
    struct LOGIN_FORM_REQUIRED{
            static let requiredUserNameLengthMin = 8
            static let requiredUserNameLengthMax = 12
            static let requiredPasswordLengthMin = 4
            static let requiredPhoneMinLength = 10
            static let requiredPhoneMaxLength = 11
            static let requiredRestaurantMinLength = 4
            static let requiredRestaurantMaxLength = 50
        }
    
    struct NOTE_FORM_REQUIRED{
        static let requiredNoteLengthMin = 2
        static let requiredNoteLengthMax = 255
    }

    
    struct UPDATE_INFO_FORM_REQUIRED{
        static let requiredNameLength = 2
        static let requiredNameLengthMax = 50
        static let requiredGender = 3

        static let requiredPassword = 4
        static let requiredPasswordMin = 4
        static let requiredPasswordMax = 20
        static let requireNameMin = 2
        static let requireNameMax = 50
        static let requireEmailLength = 50
        static let requireAddressLength = 255
    }
    
    
    struct RECEIPT_PAYMENT_MODULE{
        //trạng thái
        static let STATUS:[Int:String] = [1:"CHỜ XÁC NHẬN",2:"HOÀN TẤT",3:"ĐÃ HUỶ"]
        

        /*
            đối tượng:
            object_type = 0 -> khác
            object_type = 1 -> đơn hàng
            object_type = 2 -> phiếu nhập kho
         */
        static let OBJECT_TYPE:[Int:String] = [0:"Khoản thu khác",1:"Đơn hàng",2:"phiếu nhập kho"]
      
    }
    
    /*warning messages after call API*/
    struct WARNING_MESSAGE {
        static let ICON_WARNING = "icon-warning"
    }

    struct SUPPLIER_ORDERS_STATUS {
        static let PENDING = 0 // Đơn hàng đang chuẩn bị
        static let WAITTING_RESTAURANT_CONFIRM = 1 // Chờ nhà hàng xác nhận
        static let WAITTING_DELIVERY = 2 // Chờ giao
        static let DELIVERING = 3 // Đang giao
        static let COMPLETED = 4 // Hoàn tất - Trạng thái cuối cùng
        static let CANCELED = 5 // Đã hủy - Trạng thái cuối cùng
        static let RETURN_TO_SUPPLIER = 6 // Trả hàng về NCC
        static let CONFIRM_RETURN = 7 // Xác nhận hàng bị trả - Trạng thái cuối cùng
    }
    
    struct SUPPLIER_ORDERS_REQUEST_STATUS {
        static let PENDING = 0 // chờ kế toán xác nhận, lúc này phiếu yêu cầu mua hàng chưa gửi qua ncc
        static let WAITING_CONFIRM = 1 //  phiếu mua hàng đã được gửi sang nhà cung cấp
        static let SUPPLIER_CONFIRM = 2 // supplier xác nhận phiếu mua hàng
        static let CANCELLED = 3 // hủy phiếu mua hàng
        static let COMPLETED = 4 // Hoàn tất
        static let WAITING_RESTAURANT_CREATE_SUPPLIER_ORDER = 5 // trạng nhà hàng có thể tạo đơn hàng dựa theo phiếu mua hàng
        static let WAITING_BRANCH_OFFICE_CONFIRM = 6 // Ở trạng thái này kế toán đã gửi phiếu mua hàng sang kho tổng,và chờ kho tổng sử lý
        static let WAITING_BRANCH_OFFICE_EXPORT_MATERIAL = 7 // chờ xuất nguyên liệu theo phiếu mua hàng
        static let BRANCH_OFFICE_EXPORT_MATERIAL = 8 // kho tổng đã xuống kho chi nhánh theo thiếu mua hàng
        static let BRANCH_OFFICE_EXPORT_MATERIAL_COMPLETE = 9 // Ở trạng thái này thì kho tổng không thể xuất kho chi nhánh theo thiếu mua hàng
    }
    
    struct SUPPLIER_WAREHOUSE_SESSIONS_TYPE {
        static let IN = 0 // phiếu nhập
        static let OUT = 1 // phiếu xuất
        static let IN_RETURN = 2 // phiếu nhập trả
        static let IN_CANCEL = 3 // phiếu nhập huỷ
        static let OUT_CANCEL = 4 // phiếu xuất huỷ
        
        static let PROCESSING = 1 // Đang xử lý
        static let COMPLETED = 2 // Hoàn tất
        static let CANCELLED = 3 // Hủy
    }
    
    struct ERROR_MESSAGE {
       static let CALL_API_ERROR = "Lỗi kết nối server"
       static let ICON_ERROR = "icon-check-error"
       
    }
    
    struct SUPPLIER_CREATE_INVENTORY_TYPE {
       static let IMPORT = 0 // tạo phiếu nhập kho
       static let CANCEL = 1 // tạo phiếu huỷ
    }
}
