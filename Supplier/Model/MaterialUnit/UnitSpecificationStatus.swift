//
//  UnitSpecificationStatus.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct UnitSpecificationStatus: Mappable{
    var id = 0
    var code = ""
    var name = ""
    var description = ""
    var status = 0
    var material_category_id = 0
    var material_unit_id = 0
    var material_unit_specification_id = 0
//               material_unit: [
//                   {
//                       id: 837,
//                       code: TRUNGRAU,
//                       name: trung râu,
//                       description: Theo dự thảo, EVN sẽ được điều chỉnh tăng giá điện khi các chi phí đầu vào biến động, làm giá bán lẻ bình quân tăng từ 1% trở lên so với hiện hành.\n\nBộ Công Thương đang lấy ý kiến dự thảo về cơ chế điều chỉnh giá bán lẻ điện bình quân.\n\nTheo đó, khi các thông số đầu vào (phát điện, truyền tải, phân phối - bán lẻ điện, điều hành - quản lý ngành...) biến động làm giá bán lẻ điện bình quân tăng từ 1% trở lên, EVN sẽ được tăng giá điện. Đây là điểm mới so với quy định hiện hành (giá bán điện bình quân tăng 3% trở lên).Theo dự thảo, EVN sẽ được điều chỉnh tăng giá điện khi các chi phí đầu vào biến động, làm giá bán lẻ bình quân tăng từ 1% trở lên so với hiện hành.\n\nBộ Công Thương đang lấy ý kiến dự thảo về cơ chế điều chỉnh giá bán lẻ điện bình quân.\n\nTheo đó, khi các thông số đầu vào (phát điện, truyền tải, phân phối - bán lẻ điện, điều hành - quản lý ngành...) biến động làm giá bán lẻ điện bình quân tăng từ 1% trở lên, EVN sẽ được tăng giá điện. Đây là điểm mới so với quy định hiện hành (,
//                       status: 1,
//                       supplier_id: 172,
//                       created_at: 30/09/2022 19:17,
//                       updated_at: 12/08/2023 17:17,
//                       material_unit_specifications: [
//                           {
//                               id: 78,
//                               status: 1,
//                               name: Khanh sky,
//                               supplier_id: 172,
//                               exchange_value: 22221,
//                               material_unit_specification_exchange_name_id: 31,
//                               material_unit_specification_exchange_name: Bịch,
//                               is_deleted: 0,
//                               created_at: 06/03/2022 16:48:30,
//                               updated_at: 08/11/2022 16:56:46,
//                               supplier_material_unit_id: 837
//                           }
//                       ]
//                   }
//               ]
//
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
        description <- map["description"]
        status <- map["status"]
        material_category_id <- map["material_category_id"]
        material_unit_id <- map["material_unit_id"]
        material_unit_specification_id <- map["material_unit_specification_id"]
    }
        
}
