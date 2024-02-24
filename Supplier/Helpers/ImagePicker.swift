//
//  ImagePicker.swift
//  Techres - TMS
//
//  Created by Kelvin on 22/05/2022.
//  Copyright © 2022 ALOAPP. All rights reserved.
//

import UIKit


protocol ImagePickerProtocol {
    var lastPreparedImage: UIImage? { get }

    func startImagePicker(withSourceType sourceType: UIImagePickerController.SourceType,
                          completion: ((UIImage) -> Void)?)
}

class ImagePicker: NSObject, ImagePickerProtocol {
    private lazy var imagePicker: UIImagePickerController = {
        let pickerView = UIImagePickerController()
        
        pickerView.delegate = self
        
        return pickerView
    }()

    private let parentViewController: UIViewController

    private var onPreparedImageCallback: ((UIImage) -> Void)?

    var lastPreparedImage: UIImage?

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }

    func startImagePicker(withSourceType sourceType: UIImagePickerController.SourceType,
                          completion: ((UIImage) -> Void)?) {
        onPreparedImageCallback = completion
        imagePicker.sourceType = sourceType
        imagePicker.cameraDevice = .front
        imagePicker.cameraFlashMode = .off
        parentViewController.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation:.leftMirrored)

        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
           

            self.onPreparedImageCallback?(flippedImage)
            self.lastPreparedImage = flippedImage
        }
    }
}
