//
//  MaterialInventoryViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

//MARK: Handler dialog cancel
extension MaterialInventoryViewController: SupplierWarehouseSessionsDelegate {
    
    func callBackAcceptSupplierWarehouse(index: Int) {
        viewModel.type.accept(Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.IN) // nhập
        // Truyền mảng nguyên liệu vào
        var materialsRequest = viewModel.material_datas.value
        let materials = viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}

        materials.enumerated().forEach { (index, value) in
            var item = Material()
            item.id = value.id
            item.name = value.name
            item.material_unit_name = value.material_unit_name
            item.remain_quantity = value.remain_quantity
            item.total_import_quantity = value.total_import_quantity
            item.total_quantity_from_order = value.total_quantity_from_order
            item.price = value.price
            item.total_amount_from_quantity_import = value.total_amount_from_quantity_import
            materialsRequest.append(item)
        }
        dLog(materialsRequest)
        viewModel.material_datas.accept(materialsRequest)
        viewModel.makePopViewController()
    }
}
