

import UIKit
import RxSwift
import RxRelay
import RxCocoa
class DialogConfirmViewController: BaseViewController {
    //key for dialog type
    let REJECT_DIALOG = "REJECT_DIALOG"
    let CONFIRM_DIALOG = "CONFIRM_DIALOG"
    
 
    
    @IBOutlet private weak var lbl_dialog_title: UILabel!
    @IBOutlet private weak var view_reason: UIView!
    @IBOutlet private weak var text_view_reason: UITextView!
    @IBOutlet private weak var lbl_text_length: UILabel!
    @IBOutlet private weak var view_dialog: UIView!

    
    @IBOutlet private weak var width_of_dialog_view: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_content_dialog: UILabel!

    @IBOutlet private weak var label_btn_confirm: UILabel!
    @IBOutlet private weak var view_btn_confirm: UIView!
    
    @IBOutlet weak var view_btn_cancel: UIView!
    @IBOutlet private weak var constraint_y: NSLayoutConstraint!
    
    var dialogHeight = 250
    var dialogWidth = 350
    var dialog_title = ""
    var dialog_content = ""
    var dialog_type = ""
    var confirm_button_label = "XÁC NHẬN"
    var isAllowAttributedText:Bool = false
    var dialogConfirmDelegate: DialogConfirmDelegate?
    var diaglogRejectDelegate: DialogRejectDelegate?
    var dialogConfrimAccessEmployeeCreate: DialogConfrimCreateEmployee?
    var isCheckPopUpCreateEmployee:Bool = false
    
    var reason = BehaviorRelay<String>(value: "")
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    private func setUpForDialogReject(){
        width_of_dialog_view.constant = CGFloat(dialogWidth)
       
        lbl_dialog_title.text = dialog_title
        label_btn_confirm.text = confirm_button_label
        
        view_reason.isHidden = dialog_type == REJECT_DIALOG ? false : true
        text_view_reason.becomeFirstResponder()
        text_view_reason.withDoneButton(toolBarHeight: CGFloat(30))
        
        _ = text_view_reason.rx.text.map{(str) in
                //enable button
                self.view_btn_confirm.backgroundColor = UIColor(hex: "CCE3F1")
                self.label_btn_confirm.textColor = UIColor(hex: "0071BB")
                self.view_btn_confirm.isUserInteractionEnabled = true
                //trim leading and trailing space
                let content = str!.trimmingCharacters(in: .whitespaces)
                //check condition to unenable btn
                if(content.count >= 255 ){
                    let index = content.index(content.startIndex, offsetBy: 255)
                    let mySubstring = content.prefix(upTo: index)
                    self.text_view_reason.text = String(mySubstring)
                    self.lbl_text_length.text = String(format: "%d",content.count)
                    return String(mySubstring)
                }else if(content.count < 2){
                    self.view_btn_confirm.backgroundColor = ColorUtils.grayColor()
                    self.label_btn_confirm.textColor = ColorUtils.white()
                    self.view_btn_confirm.isUserInteractionEnabled = false
                }
                self.lbl_text_length.text = String(format: "%d",content.count)
                return content
            }.bind(to: reason).disposed(by: rxbag)
        
    }
    
    private func setUpForDialogConfirm(){
        width_of_dialog_view.constant = CGFloat(dialogWidth)
        lbl_dialog_title.text = dialog_title
        if !isAllowAttributedText{lbl_content_dialog.text = dialog_content}
        view_reason.removeFromSuperview()
        label_btn_confirm.text = confirm_button_label
        view_btn_confirm.isUserInteractionEnabled = true
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view_dialog.round(with: .both, radius: 8)
        switch dialog_type {
            case CONFIRM_DIALOG:
                setUpForDialogConfirm()
                return
            case REJECT_DIALOG :
                setUpForDialogReject()
                return
            default:
                return
        }
    }
    
    
    @IBAction func actionToCancel(_ sender: Any) {
        if isCheckPopUpCreateEmployee {
            dialogConfrimAccessEmployeeCreate?.callBackDialogConfrimCreateEmployeePopup(check: 1)
        }else {
            dismiss(animated: true)
        }
        
    }
    
    
    @IBAction func actionToConfirm(_ sender: Any) {
        
        dialog_type == CONFIRM_DIALOG
        ? dialogConfirmDelegate?.callBackToConfirm()
        : diaglogRejectDelegate?.callBackToReject(reason: reason.value)
        
        dismiss(animated: true)
    }
}
