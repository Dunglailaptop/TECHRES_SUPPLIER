//
//  RestaurantOrderReportViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_01 on 04/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts




extension RestaurantOrderReportViewController {
    //MARK: Register Cells as you want
    func registerCell(){
        let restaurantOrderReportTableViewCell = UINib(nibName: "RestaurantOrderReportTableViewCell", bundle: .main)
        tableView.register(restaurantOrderReportTableViewCell, forCellReuseIdentifier: "RestaurantOrderReportTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
    }
    
    
    func bindTableView(){
        viewModel.restaurantOrder.bind(to: tableView.rx.items(cellIdentifier: "RestaurantOrderReportTableViewCell", cellType: RestaurantOrderReportTableViewCell.self))
            {(row, data, cell) in
                cell.data = data
                cell.viewModel = self.viewModel
            }.disposed(by: rxbag)
    }
    

}

extension RestaurantOrderReportViewController{
    func setupPieChart(restaurantOrder: [RestaurantOrderReport]) {
            self.pieChartRestaurantOrder.noDataText = NSLocalizedString("Chưa có dữ liệu !!", comment: "")
            var pieChartItems = [PieChartDataEntry]()
            pieChartItems.removeAll()
            
            var s = 0.0
            for i in 0 ..< restaurantOrder.count {
                s += Double(restaurantOrder[i].total_amount)
            }
            
            for i in 0 ..< restaurantOrder.count {
                pieChartItems.append(PieChartDataEntry(value: Double(restaurantOrder[i].total_amount), label: Utils.stringVietnameseMoneyFormatWithNumber(amount: restaurantOrder[i].total_amount)))
                self.colors.append(ColorUtils.random())
            }
            let pieChartDataSet = PieChartDataSet(entries: pieChartItems, label: "")
            pieChartDataSet.colors = self.colors
            pieChartDataSet.sliceSpace = 2
            pieChartDataSet.selectionShift = 5
            pieChartDataSet.xValuePosition = .insideSlice
            pieChartDataSet.yValuePosition = .insideSlice
            pieChartDataSet.valueTextColor = UIColor.clear
            pieChartDataSet.valueLineWidth = 0.5
            pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
            pieChartDataSet.valueLinePart2Length = 0.2
            pieChartDataSet.drawValuesEnabled = false
            pieChartDataSet.drawIconsEnabled = true

            var legendEntries = [LegendEntry]()
            
            for i in 0 ..< restaurantOrder.count {
                let label = String(restaurantOrder[i].name)
                let color = colors[i]
                let legendEntry = LegendEntry(label: label)
                legendEntries.append(legendEntry)
            }
            
            let legend = pieChartRestaurantOrder.legend
            legend.setCustom(entries: legendEntries)
        
            let noZeroFormatter = NumberFormatter()
            noZeroFormatter.zeroSymbol = ""
            pieChartDataSet.valueFormatter = CustomChartView()
            ChartUtils.customPieChart(chartView: pieChartRestaurantOrder, total: Int(s))
            let data = PieChartData(dataSet: pieChartDataSet)
            pieChartRestaurantOrder.data = data
            pieChartRestaurantOrder.data?.isHighlightEnabled = false
            
        }
    
}

