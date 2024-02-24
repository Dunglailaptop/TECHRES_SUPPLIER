//
//  CustomTabBar.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class CustomTabBar: UIStackView {
    
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    
    private lazy var customItemViews: [CustomItemView] = [generalItem, managerItem, messageItem, notificationItem, utilitiesItem]
    
    private let generalItem = CustomItemView(with: .general, index: 0)
    private let managerItem = CustomItemView(with: .manager, index: 1)
    private let messageItem = CustomItemView(with: .message, index: 2)
    private let notificationItem = CustomItemView(with: .notification, index: 3)
    private let utilitiesItem = CustomItemView(with: .utilities, index: 4)
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupProperties()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addArrangedSubviews([generalItem, managerItem, messageItem, notificationItem, utilitiesItem])
    }
    
    private func setupProperties() {
        distribution = .fillEqually
        alignment = .center
        
        backgroundColor = .systemIndigo
        setupCornerRadius(20)
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
    
    //MARK: - Bindings
    
    private func bind() {
        generalItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.generalItem.animateClick {
                    self.selectItem(index: self.generalItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        managerItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.managerItem.animateClick {
                    self.selectItem(index: self.managerItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        messageItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.messageItem.animateClick {
                    self.selectItem(index: self.messageItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        notificationItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.notificationItem.animateClick {
                    self.selectItem(index: self.notificationItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        
        utilitiesItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.utilitiesItem.animateClick {
                    self.selectItem(index: self.utilitiesItem.index)
                }
            }
            .disposed(by: disposeBag)
        
       
    }
}
