//
//  ItemsManagementDialogViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
class ItemsManagementDialogViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    private let myArray: NSArray = ["First","Second","Third"]
    private var myTableView: UITableView!
    private var mainView:UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = UIView(frame: CGRect(x:0,y:0,width: CGFloat(300), height: CGFloat(500)))
        mainView.center = self.view.center
        mainView.backgroundColor = .white
        self.view.addSubview(mainView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window

        
        myTableView = UITableView(frame: CGRect(x: 0, y: mainView.bounds.origin.y + 120, width: mainView.frame.width, height:  mainView.frame.height - 120))
        
        setMainView(mainView: mainView)
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        mainView.addSubview(myTableView)
    }
    
    @objc func handleTapOutSide(_ gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: mainView)
        dLog(tapLocation)
        if !mainView.bounds.contains(tapLocation){
           dismiss(animated: true)
        }
    }
    
    private func setMainView(mainView:UIView){
        
        /*
            the process to add subview and set constraint for it:
            step1: create UIView and we also set property for it at this step
            step2: add subview to the parent view
            step3: define the constraints (Use the NSLayoutConstraint class to define the constraints for the subview)
            step4: Activate the constraints
         */
        
        let titleView = UIView(frame: CGRect(origin: mainView.bounds.origin, size: CGSize(width: mainView.frame.width, height: 120)))
        /*icon warning*/
        let uiImageView = UIImageView(image: UIImage(named: "icon-warning"))
        uiImageView.frame = CGRect(origin: titleView.bounds.origin, size: CGSize(width: 50, height: 50))
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(uiImageView)//step2
        let topConstraintForImage = NSLayoutConstraint(item: uiImageView, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .top, multiplier: 1.0, constant: 20)
        let centerXForImage = NSLayoutConstraint(item: uiImageView, attribute: .centerX, relatedBy: .equal, toItem: titleView, attribute: .centerX, multiplier: 1, constant: 0)
        /*add label*/
        let label = UILabel(frame:  CGRect(origin: CGPoint(x: 0, y: 50), size: CGSize(width: titleView.frame.width, height: 50)))
//        label.frame.origin =  CGPoint(x: 0, y: 50)
        label.text = "Nguyên liệu đang được sử dụng!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16,weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true

        titleView.addSubview(label)
        let topConstraintForLabel = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: uiImageView, attribute: .top, multiplier: 1.0, constant: 15)
        let centerXForLabel = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: titleView, attribute: .centerX, multiplier: 1, constant: 0)
        let leadingConstraintForLabel = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: titleView, attribute: .leading, multiplier: 1.0, constant: 20)
        let trailingConstraintForLabel = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: titleView, attribute: .trailing, multiplier: 1.0, constant: -20)
      
        var contraintArray = [
            topConstraintForImage,
            centerXForImage,
            leadingConstraintForLabel,
            trailingConstraintForLabel,
            topConstraintForLabel,
            centerXForLabel
        ]
    
        titleView.addConstraints(contraintArray)// Add constraints to the parent view
        for constraint in contraintArray{
            constraint.isActive = true
        }
        mainView.addSubview(titleView)
        myTableView = UITableView(frame: CGRect(x: 0, y: mainView.bounds.origin.y + 120, width: mainView.frame.width, height:  mainView.frame.height - 120))
        setTableHeader(table: myTableView)
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("Num: \(indexPath.row)")
      print("Value: \(myArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return myArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
      cell.textLabel!.text = "\(myArray[indexPath.row])"
      return cell
    }

    
    private func setTableHeader(table:UITableView){
        let headerView = UIStackView(frame: CGRect(x: 0, y: 0, width: table.frame.width, height: 50))
        headerView.spacing = 5
        headerView.backgroundColor = .blue
   
        
        
        let headerSubView1 = UIView(frame:  CGRect(x: headerView.bounds.origin.x, y:  headerView.bounds.origin.y,
                                                width: table.frame.width/3, height: 50))
        headerSubView1.backgroundColor = .white
        let titleOfSubview1 = UILabel(frame: headerSubView1.bounds)
        titleOfSubview1.text = "Tên nhà hàng"
        titleOfSubview1.textAlignment = .center
        titleOfSubview1.textColor = .black
        headerSubView1.addSubview(titleOfSubview1)
        
        
        let headerSubView2 = UIView(frame: CGRect(x: headerView.bounds.size.width/3, y: headerView.bounds.origin.y,
                                              width: table.frame.width/3, height: 50))
        headerSubView2.backgroundColor = .white
        let titleOfSubview2 = UILabel(frame: headerSubView2.bounds)
        titleOfSubview2.text = "Tổng phiếu đặt hàng"
        titleOfSubview2.textAlignment = .center
        titleOfSubview2.textColor = .black
        headerSubView2.addSubview(titleOfSubview2)
        
        
        let headerSubView3 = UIView(frame: CGRect(x: headerView.bounds.size.width*2/3, y:headerView.bounds.origin.y,
                                                width: table.frame.width/3, height: 50))
        headerSubView3.backgroundColor = .white
        let titleOfSubview3 = UILabel(frame: headerSubView3.bounds)
        titleOfSubview3.text = "Tổng đơn hàng"
        titleOfSubview3.textAlignment = .center
        titleOfSubview3.textColor = .black
        headerSubView3.addSubview(titleOfSubview3)
        
        
        headerView.addSubviews(headerSubView1,headerSubView2,headerSubView3)
        table.tableHeaderView = headerView
    }
}
