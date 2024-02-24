//
//  ReportCategoryViewController+Extension+Chart+Proccess.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts

extension CancelCategoryReportViewController{
    func setUpPieChart(dataChart: [MaterialReportData]) {
        self.pie_chart.noDataText = NSLocalizedString("Chưa có dữ liệu !!", comment: "")
        pieChartItems.removeAll()
        
        var s = 0.0
        for i in 0 ..< dataChart.count {
            s += Double(dataChart[i].total_cancel)
        }
        
        for i in 0 ..< dataChart.count {
            pieChartItems.append(PieChartDataEntry(value: Double(dataChart[i].total_cancel), label: Utils.stringVietnameseMoneyFormatWithNumber(amount: dataChart[i].total_cancel)))
        }
        
        for (index, _) in dataChart.enumerated() {
            self.colors.append(index < colors.count ? colors[index] : UIColor(hex: "5470c6"))
            // Assign the color to the data point in your chart
        }
        
        let pieChartDataSet = PieChartDataSet(entries: self.pieChartItems, label: "")
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
        pieChartDataSet.drawIconsEnabled = false
        
        
        let noZeroFormatter = NumberFormatter()
        noZeroFormatter.zeroSymbol = ""
        pieChartDataSet.valueFormatter = CustomChartView()
        ChartUtils.customPieChart(chartView: pie_chart, total: Int(s))
        let data = PieChartData(dataSet: pieChartDataSet)
        pie_chart.data = data
        pie_chart.data?.isHighlightEnabled = false
        
    }
}
