//
//  DialogAcceptPendingInventoryViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAcceptPendingInventoryViewController: BaseViewController {
    var viewModel = DetailPendingInventoryViewModel()
    
    @IBOutlet weak var root_view: UIView!
    
    @IBOutlet weak var lbl_content: UILabel!
    var delegate: SupplierOrdersDelegate?
    var id = 0
    var index = 0
    var isCheckSpam:Bool = false
    var dialogContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_content.text = dialogContent
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
        self.delegate?.callBackAcceptSupplierOrders(index: index)
        self.dismiss(animated: true)
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
