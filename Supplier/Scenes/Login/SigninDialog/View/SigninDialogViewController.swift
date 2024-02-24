//
//  SigninDialogViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class SigninDialogViewController: UIViewController {

    @IBOutlet weak var main_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
                tapGesture.cancelsTouchesInView = false
                UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    @objc private func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
            let tapLocation = gesture.location(in: main_view)
            if !main_view.bounds.contains(tapLocation) {
                   // Handle touch outside of the view
                   dismiss(animated: true, completion: nil)
               }
        }
 

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionChooseReportType(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            openAppZalo()
            break
        case 2:
            openMessgaeFacebook()
            break
        case 3:
            openHotline()
            break
        default:
            return
        }
    }
    
    func openAppZalo() {
        if let url = URL(string: "https://zalo.me/0916357018"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
//                    JonAlert.show(message: "App Store Opened")
                }
            }
        } else {
//            JonAlert.show(message: "Can't Open URL on Simulator")
        
        }
    }
    
    func openMessgaeFacebook() {
            guard let productURL = URL(string: "https://m.me/techres.order") else {
                return
            }
            
            var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)

            // 2.
            components?.queryItems = [
              URLQueryItem(name: "action", value: "write-review")
            ]

            // 3.
            guard let writeReviewURL = components?.url else {
              return
            }

            // 4.
            UIApplication.shared.open(writeReviewURL)
     }
    
    func openHotline() {
        let phoneNumber = "0925123123"

               if canMakePhoneCall() {
                   // Hỗ trợ gọi điện, mở ứng dụng điện thoại và nhập sẵn số
                   if let url = URL(string: "tel://\(phoneNumber)") {
                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                   }
               } else {
                   // Không hỗ trợ gọi điện, hiển thị thông báo
                   let alertController = UIAlertController(title: "Số điện thoại liên hệ", message: phoneNumber, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
               }
    }
    // Kiểm tra xem thiết bị có hỗ trợ cuộc gọi điện thoại không
       func canMakePhoneCall() -> Bool {
           guard let url = URL(string: "tel://") else { return false }
           return UIApplication.shared.canOpenURL(url)
       }
}
