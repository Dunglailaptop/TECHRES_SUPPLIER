//
//  DialogCancelPendingInventoryViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class DialogCancelPendingInventoryViewController: BaseViewController {
    var viewModel = DetailPendingOrderViewModel()
    
    @IBOutlet weak var text_field_reason: UITextView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lbl_limit_character: UILabel!
    @IBOutlet weak var root_view: UIView!
    @IBOutlet weak var view_btn_confirm: UIView!
    
    @IBOutlet weak var constraint_y_center: NSLayoutConstraint!
    
    var delegate: SupplierOrdersDelegate?
    var id = 0
    var isCheckSpam:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        root_view.round(with: .both, radius: 8)
        text_field_reason.withDoneButton()
        text_field_reason.becomeFirstResponder()
        
        _ = text_field_reason.rx.text.map { $0!.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" }.bind(to: viewModel.reason)

        _ = viewModel.isValid.subscribe({ [weak self] isValid in

            guard let strongSelf = self, let isValid = isValid.element else { return }
            strongSelf.btnConfirm.isEnabled = isValid
            strongSelf.btnConfirm.backgroundColor = isValid ? ColorUtils.blueTransparent() : ColorUtils.buttonGrayColor()
            
        })
        // Cắt chuỗi khi vượt quá 255 kí tự
        text_field_reason.rx.text
            .orEmpty // convert to non-optional string
            .map { $0.prefix(255) } // limit to max length
            .subscribe(onNext: { [weak self] newText in
                self?.text_field_reason.text = String(newText)
            })
            .disposed(by: rxbag)
        // Đếm ký tự
        text_field_reason.rx.text
                      .subscribe(onNext: {
                          self.lbl_limit_character.text = String(format: "%d/%d", $0!.count, 255)
                      })
                      .disposed(by: rxbag)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications()
        tapGesture()
    }

    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func actionApproved(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                }
        self.delegate?.callBackCancelSupplierOrders(cancel_reason:text_field_reason.text)
        self.dismiss(animated: true)
    }

    func setupKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func adjustForKeyboard(_ notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            constraint_y_center.constant = 0
        } else {
            constraint_y_center.constant = keyboardViewEndFrame.height - root_view.frame.height - 220
        }
    }
    
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        //                view.superview?.addGestureRecognizer(tapGesture) // Attach to the superview
        // OR
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view)
        if !root_view.bounds.contains(tapLocation) {
                dismiss(animated: true, completion: nil)
        }
    }
}
