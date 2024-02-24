//
//  ToolTipDescriptions.swift
//  SEEMT
//
//  Created by Macbook Pro M1 Techres - BE65F182D41C on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import Foundation

struct Description {
    struct Label {
        static let defaultLabel = "This is a Label, a Label displays text"
        static let otherLabel = "This is another label, this label can also display text"
        static let justMore = "Just one more tooltip"
    }
    
    struct Button {
        static let defaultButton = "This is a button, a button can be pressed to perform an action."
    }
    
    struct ImageView {
        static let defaultImageView = "This is an imageView, an imageView can display images"
        static let otherImageViews = "You can also use SwiftyToolTip to add a description to images, add their copyrights or a funny caption."
    }
    
    struct OtherUIElements {
        static let segmentedControl = "A segmented control gives you 2 or more option to select from"
        static let slider = "Adjust a slider to change a give range of numbers"
        static let progressView = "The progress view shows you the progress of a certain task"
    }
    
    struct BarButtonItems {
        static let backButton = "Go back to the previous view controller without doing anything"
        static let cancelButton = "Go back to previous view controller and cancel all tasks or information given"
        static let saveButton = "Saves the new data and continues you to the next step"
        static let addButton = "Opens a new screen where you can create a new thing for your app"
    }
    
    struct tabBar {
        static let tabbar = "Here you can switch between different sections of the app"
        static let storyboardViewController = "Here we display a tableview with some tooltips."
        static let otherViewcontroller = "Here we display other stuff"
    }
}
