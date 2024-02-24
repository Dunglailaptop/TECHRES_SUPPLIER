//
//  LoadWebLinkViewController.swift
//  ALOLINE
//
//  Created by Kelvin on 06/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import WebKit

class LoadWebLinkViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var title_header = "CHƯƠNG TRÌNH KHUYẾN MÃI"
    var link = "https://123-zo.vn/intro-hau.html"
    @IBOutlet weak var lbl_title_header: UILabel!
    //  var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_title_header.text = title_header 
     
    }
   
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
