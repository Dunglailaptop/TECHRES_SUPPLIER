//
//  FeedBackViewController.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import JonAlert
class FeedBackViewController: BaseViewController {
    var viewModel = FeedBackViewModel()
    var router = FeedBackRouter()
    var listTypeOfFilterDialog = [String]()
    
    @IBOutlet weak var lbl_sender: UILabel!
    @IBOutlet weak var lbl_phone_number: UILabel!
    
    @IBOutlet weak var lbl_text_length: UILabel!
    @IBOutlet weak var lbl_filter_type: UILabel!
    @IBOutlet weak var btn_show_filter: UIButton!
    
    @IBOutlet weak var btn_confirm: UIButton!
    @IBOutlet weak var text_field_email: UITextField!
    @IBOutlet weak var lbl_email_err: UILabel!
    @IBOutlet weak var text_view: UITextView!
    
    @IBOutlet weak var lbl_description_err: UILabel!
    
    @IBOutlet weak var view_btn: UIView!
    
    
    @IBOutlet weak var btn_confirm_view: UIView!
    @IBOutlet weak var lbl_confirm_btn: UILabel!
    
    @IBOutlet weak var icon_confirm: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        firstSetUp()
    }
        
    private func firstSetUp(){
        
        text_view.withDoneButton()
        validateAndMappingData()
        lbl_sender.text = viewModel.name.value
        lbl_phone_number.text = viewModel.phone.value
        view_btn.roundCorners(corners:[.topLeft,.topRight], radius: 18)
        view_btn.shadowOpacity = 0.5
        text_view.setPlaceholderColor("Diễn giải", false)
        listTypeOfFilterDialog.append("Bạn muốn góp ý về điều gì?")
        listTypeOfFilterDialog.append("Yêu cầu cải tiến")
        listTypeOfFilterDialog.append("Đề nghị làm lại")
        hideAllErr()
    }
    
    func hideAllErr(){
        lbl_email_err.isHidden = true
        lbl_description_err.isHidden = true
    }


    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func actionToConfirm(_ sender: Any) {
        _ = isValid.take(1).subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            if isValid {
                self!.sendFeedBack()
            }
        }).disposed(by: rxbag)
    }
    
    
    @IBAction func actionToShowFilter(_ sender: Any) {
        showFilter()
    }
    
}
