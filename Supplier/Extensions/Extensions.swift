//
//  Extensions.swift
//  Seemt
//
//  Created by kelvin on 18/12/2022.
//

import UIKit
import iOSDropDown
extension UILabel {
    func configureWith(_ text: String,
                       color: UIColor,
                       alignment: NSTextAlignment,
                       size: CGFloat,
                       weight: UIFont.Weight = .regular) {
        self.font = .systemFont(ofSize: size, weight: weight)
        
     
        
        
        var title = ""
        if(text == "Kaizen"){
            title = "Kaizen"
        }else if(text == "Worksplace"){
            title = "Seemt"
//        }
//        else if(text == "Message"){
//            title = "Tin nhắn"
        }else if(text == "Notification"){
            title = "Thông báo"
        }else if(text == "Account"){
            title = "Tài khoản"
        }
      
        self.text = text
        self.textColor = ColorUtils.grayColor()
        self.textAlignment = alignment
    }
}

extension UIView {
    func setupCornerRadius(_ cornerRadius: CGFloat = 0, maskedCorners: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius
        if let corners = maskedCorners {
            layer.maskedCorners = corners
        }
    }
    
    func animateClick(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in completion() }
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 7
        layer.backgroundColor = ColorUtils.white().cgColor
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
       let isValidIndex = index >= 0 && index < count
       return isValidIndex ? self[index] : nil
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}







