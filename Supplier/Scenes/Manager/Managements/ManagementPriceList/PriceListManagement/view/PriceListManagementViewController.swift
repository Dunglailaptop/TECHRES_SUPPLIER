//
//  PriceListManagementViewController.swift


import UIKit
import RxSwift
class PriceListManagementViewController: BaseViewController {
    
   var viewModel = PriceListManagementViewModel()
    var router = PriceListManagementRouter()
    
    let FROM_DATE = "FROM_DATE"
    let TO_DATE = "TO_DATE"
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var lbl_from_date: UILabel!
//
//    @IBOutlet weak var lbl_to_date: UILabel!
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var view_empty_data: UIView!
    
    var listTypeOfFilterDialog = [String]()
    
    @IBOutlet weak var btn_choose_status: UIButton!
    
    
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    var lastPosion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        firstSetup()
        Register()
        bindingtable()
//        lbl_from_date.text = Utils.getCurrentDateString()
//        lbl_to_date.text = Utils.getCurrentDateString()
        viewModel.from_date.accept(Utils.getCurrentDateString())
        viewModel.to_date.accept(Utils.getCurrentDateString())
      
    }
    
    private func firstSetup(){
        Utils.isHideAllView(isHide: true, view: self.view_empty_data)
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       
                     
                       viewModel.key_search.accept(query!)
                       
                       viewModel.ClearDataAndCallApi()
                       
        }).disposed(by: rxbag)
              
    
        
        
//        //setup filter option
//        listTypeOfFilterDialog.append("Tất cả")
//        listTypeOfFilterDialog.append("Đã Duyệt")
//        listTypeOfFilterDialog.append("Đã Từ chối")
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ClearDataAndCallApi()
    }
    
    
    @IBAction func actionFilterStatus(_ sender: Any) {
        
    }
    
    
//    @IBAction func actionChooseDateFrom(_ sender: Any) {
//        viewModel.dateType.accept(FROM_DATE)
//        dLog(viewModel.to_date.value)
//        self.showDateTimePicker(dateTimeData:viewModel.from_date.value)
//    }
//
//
//    @IBAction func actionChooseDateTo(_ sender: Any) {
//        viewModel.dateType.accept(TO_DATE)
//        dLog(viewModel.to_date.value)
//        self.showDateTimePicker(dateTimeData:viewModel.to_date.value)
//    }
    
    @IBAction func btnActionPopView(_ sender: Any) {
        viewModel.makePopViewController()
    }
}
