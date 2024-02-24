//
//  CustomItemView.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import SnapKit

final class CustomItemView: UIView {
    
    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    private let underlineView = UIView()
    private let containerView = UIView()
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    private let item: CustomTabItem
    
    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubviews(nameLabel, iconImageView, underlineView)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        underlineView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(4)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
    
    private func setupProperties() {
        nameLabel.configureWith(item.name,
                                color: .white.withAlphaComponent(0.4),
                                alignment: .center,
                                size: 11,
                                weight: .semibold)
        underlineView.backgroundColor = ColorUtils.blue_color()
        underlineView.setupCornerRadius(2)
        
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        
        if(self.index == 1){
            containerView.tag = self.index
            let label: UILabel = UILabel()
            label.frame = CGRectMake(42, 0, 30, 18)
            label.backgroundColor = ColorUtils.red_color()
            label.textAlignment = NSTextAlignment.center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 9
            label.borderWidth = 2
            label.borderColor = ColorUtils.white()
            label.tag = TAG_NOTIFICATION_BAGVALUE_MANAGER
            label.configureWith("1",
                                color: .white,
                                        alignment: .center,
                                        size: 10,
                                weight: .bold)
            
            label.isHidden = true
            containerView.addSubview(label)
        }else if(self.index == 2){
                containerView.tag = self.index
                let label: UILabel = UILabel()
                label.frame = CGRectMake(42, 0, 30, 18)
                label.backgroundColor = ColorUtils.red_color()
                label.textAlignment = NSTextAlignment.center
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 9
                label.borderWidth = 2
            label.borderColor = .white
                label.tag = TAG_NOTIFICATION_BAGVALUE_NOTIFICATION
                label.configureWith("1",
                                    color: .white,
                                            alignment: .center,
                                            size: 10,
                                    weight: .bold)
            
                label.isHidden = true
                containerView.addSubview(label)
            
        }else if(self.index == 3){
            containerView.tag = self.index
            let label: UILabel = UILabel()
            label.frame = CGRectMake(42, 0, 30, 18)
            label.backgroundColor = ColorUtils.red_color()
            label.textAlignment = NSTextAlignment.center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 9
            label.borderWidth = 2
            label.borderColor = ColorUtils.white()
            label.tag = TAG_NOTIFICATION_BAGVALUE_MESSAGE
            label.configureWith("1",
                                color: .white,
                                        alignment: .center,
                                        size: 10,
                                weight: .bold)
        
            label.isHidden = true
            containerView.addSubview(label)
        
    }
        
    }
    
    private func animateItems() {
        UIView.animate(withDuration: 0.4) { [unowned self] in
            self.nameLabel.alpha = self.isSelected ? 0.0 : 1.0
            self.underlineView.alpha = self.isSelected ? 1.0 : 0.0
        }
        UIView.transition(with: iconImageView,
                          duration: 0.4,
                          options: .transitionCrossDissolve) { [unowned self] in
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
}
