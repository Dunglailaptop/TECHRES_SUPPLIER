
import UIKit
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert
class AddressDialogOfAccountInforViewController: BaseViewController {
    var viewModel = AddressDialogOfAccountInforViewModel()
    var router = AddressDialogOfAccountInforRouter()
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var icon_btn_confirm: UIImageView!
    @IBOutlet weak var lbl_btn_confirm: UILabel!
    @IBOutlet weak var btn_confirm: UIButton!
    @IBOutlet weak var view_btn_confirm: UIView!
    
    @IBOutlet weak var lbl_dialog_title: UILabel!
    
    var delegate:AccountInforDelegate?
    var areaType = ""
    var selectedArea:[String:Area] = [String:Area]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstSetup()
    }
    
    
    private func firstSetup(){
        disableButton()
        viewModel.beingSelectedArea.accept(selectedArea)
        switch areaType {
            case "CITY":
                getCitiesList()
                break
            case "DISTRICT":
                getDistrictsList()
                break
            default:
                if (viewModel.beingSelectedArea.value["WARD"]!.id == 0 && viewModel.beingSelectedArea.value["WARD"]!.name == ""){
                    disableButton()
                }else{
                    enableButton()
                }
                getWardList()
                break
        }
        
        text_field_search.rx.controlEvent(.editingChanged)
             .withLatestFrom(text_field_search.rx.text)
               .subscribe(onNext:{ [self] query in
                   let cloneAreaDataFilter = viewModel.areaDataFilter.value
                   if !query!.isEmpty{
                       var filteredWarehouseMaterialList = cloneAreaDataFilter.filter({
                           (value) -> Bool in
                           let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           return str2.contains(str1)
                       })
                       viewModel.areaData.accept(filteredWarehouseMaterialList)
                   }else{
                       viewModel.areaData.accept(cloneAreaDataFilter)
                   }
        }).disposed(by: rxbag)
    }
    
    func disableButton() {
        view_btn_confirm.isHidden = true
        lbl_btn_confirm.textColor = ColorUtils.white()
        view_btn_confirm.backgroundColor = ColorUtils.gray_200()
        icon_btn_confirm.image = UIImage(named: "icon-check-white")
        btn_confirm.isEnabled = false
    }
    
    func enableButton() {
        view_btn_confirm.isHidden = false
        lbl_btn_confirm.textColor = ColorUtils.blue()
        view_btn_confirm.backgroundColor = ColorUtils.blueTransparent()
        icon_btn_confirm.image = UIImage(named: "icon-blue-checked")
        btn_confirm.isEnabled = true
    }
    
    @IBAction func actionCancel(_ sender: Any) {        
        dismiss(animated: true)
    }

    @IBAction func actionConfirm(_ sender: Any) {
        //Check whether user's selection is valid or not
        delegate?.callBackToAcceptSelectedArea(selectedArea: viewModel.beingSelectedArea.value)
        dismiss(animated: true)
    }
    
}



extension AddressDialogOfAccountInforViewController{
    func registerCell() {
        let cityCell = UINib(nibName: "AddressDialogOfAccountInforTableViewCell", bundle: .main)
        tableView.register(cityCell, forCellReuseIdentifier: "AddressDialogOfAccountInforTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView.rx.modelSelected(Area.self).subscribe(onNext: { [self] element in
            
            /*The logic is: if user click on the old-area, we will keep the their previous set of selected areas, else
                user click on new area, we will set the next options to nil (null)
             */
            switch areaType{
                case "CITY":
                    if(element.id != viewModel.beingSelectedArea.value["CITY"]!.id){
                        var cloneBeingSelectedArea = viewModel.beingSelectedArea.value
                        var obj = element
                        obj.is_select = ACTIVE
                        cloneBeingSelectedArea.updateValue(obj, forKey: "CITY")
                        cloneBeingSelectedArea.updateValue(Area()!, forKey: "DISTRICT")
                        cloneBeingSelectedArea.updateValue(Area()!, forKey: "WARD")
                        viewModel.beingSelectedArea.accept(cloneBeingSelectedArea)
                    }
                    areaType = "DISTRICT"
                    getDistrictsList()
                    break

                case "DISTRICT":
                    if(element.id != viewModel.beingSelectedArea.value["DISTRICT"]!.id){
                        var cloneBeingSelectedArea = viewModel.beingSelectedArea.value
                        var obj = element
                        obj.is_select = ACTIVE
                        cloneBeingSelectedArea.updateValue(obj, forKey: "DISTRICT")
                        cloneBeingSelectedArea.updateValue(Area()!, forKey: "WARD")
                        viewModel.beingSelectedArea.accept(cloneBeingSelectedArea)
                    }
                    areaType = "WARD"
                    getWardList()
                    break

                default:
                    if(element.id != viewModel.beingSelectedArea.value["WARD"]!.id){
                        var cloneBeingSelectedArea = viewModel.beingSelectedArea.value
                        var obj = element
                        obj.is_select = ACTIVE
                        cloneBeingSelectedArea.updateValue(obj, forKey: "WARD")
                        viewModel.beingSelectedArea.accept(cloneBeingSelectedArea)
                    }
                    enableButton()
                    reRenderDataArray(dataArray: viewModel.areaData.value, selectedAreaId: element.id)
                    break
            }
        })
        .disposed(by: rxbag)

    }
    
    func bindTableViewData() {
        viewModel.areaData.bind(to: tableView.rx.items(cellIdentifier: "AddressDialogOfAccountInforTableViewCell", cellType: AddressDialogOfAccountInforTableViewCell.self))
        {  (row, area, cell) in
            cell.area = area
        }.disposed(by: rxbag)

    }
    
    private func reRenderDataArray(dataArray:[Area],selectedAreaId:Int){
        var cloneDataArray = dataArray
        if var position = dataArray.firstIndex(where: {data in data.is_select == ACTIVE}){
            cloneDataArray[position].is_select = DEACTIVE
        }
        
        if var position = cloneDataArray.firstIndex(where: {data in data.id == selectedAreaId}){
            cloneDataArray[position].is_select = ACTIVE
        }
        viewModel.areaData.accept(cloneDataArray)
    }
    
    private func showWarningMassage(content:String){
        JonAlert.show(
        message: content ?? "",
        andIcon: UIImage(named: ""),
        duration: 2.0)
    }
    
    
    
}

extension AddressDialogOfAccountInforViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: call API here
extension AddressDialogOfAccountInforViewController{
    func getCitiesList(){
        viewModel.getCitiesList().subscribe(onNext: { [self]
            (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if  var dataFromServer = Mapper<Area>().mapArray(JSONObject: response.data){
                    if let position = dataFromServer.firstIndex(where: {area in area.id == viewModel.beingSelectedArea.value["CITY"]!.id}){
                        dataFromServer[position].is_select = ACTIVE
                    }
                    lbl_dialog_title.text = "CHỌN TỈNH THÀNH PHỐ"
                    viewModel.areaDataFilter.accept(dataFromServer)
                    viewModel.areaData.accept(dataFromServer)
                }
            }else{

                JonAlert.showError(message: response.message ?? "Lỗi kết nối server",duration:2.0)
                
            }
        })
    }
    
    func getDistrictsList(){
        viewModel.getDistrictsList().subscribe(onNext: { [self]
            (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if var dataFromServer = Mapper<Area>().mapArray(JSONObject:response.data){
                    if let position = dataFromServer.firstIndex(where: {area in area.id == viewModel.beingSelectedArea.value["DISTRICT"]!.id}){
                        dataFromServer[position].is_select = ACTIVE
                    }
                    lbl_dialog_title.text = "CHỌN QUẬN HUYỆN"
                    viewModel.areaDataFilter.accept(dataFromServer)
                    viewModel.areaData.accept(dataFromServer)
                    
                }
            }else {
                JonAlert.showError(message: response.message ?? "Lỗi kết nối server",duration:2.0)
            }
            
        })
    }
    
    
    func getWardList(){
        viewModel.getWardsList().subscribe(onNext: { [self]
            (response) in
            if(response.code  == RRHTTPStatusCode.ok.rawValue){
                if var dataFromServer = Mapper<Area>().mapArray(JSONObject:response.data){
                    
                    if let position = dataFromServer.firstIndex(where: {area in area.id == viewModel.beingSelectedArea.value["WARD"]!.id}){
                        dataFromServer[position].is_select = ACTIVE
                    }
                    lbl_dialog_title.text = "CHỌN XÃ PHƯỜNG"
                    viewModel.areaDataFilter.accept(dataFromServer)
                    viewModel.areaData.accept(dataFromServer)
                }
            }else {
                JonAlert.showError(message: response.message ?? "Lỗi kết nối server",duration:2.0)
            }
        })
    }
    
}
