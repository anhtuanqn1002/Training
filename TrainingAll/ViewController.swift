//
//  ViewController.swift
//  TrainingAll
//
//  Created by Anh Tuan on 3/13/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//
import UIKit
import Photos
import PhotosUI
class ViewController: UIViewController, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapButon(_ sender: Any) {
        if #available(iOS 14, *) {
            let config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        } else {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.mediaTypes = ["public.image", "public.movie"]
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let assetId = results.first?.assetIdentifier,
           let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject
        {
            print("asset is \(asset)")
            PHImageManager.default().requestImageDataAndOrientation(for: asset, options: nil) { data, s, orientation, info in
                print("\(data?.count)")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as? UIImage
        let originalJPEGCount = originalImage?.jpegData(compressionQuality: 1.0)?.count
        let originalPNGCount = originalImage?.pngData()?.count
        let imageURL = info[.imageURL] as? URL
        if let asset = info[.phAsset] as? PHAsset {
            // Bị deprecated trên iOS 13
            PHImageManager.default().requestImageData(for: asset, options: nil) { data, name, orientation, info in
                print(data?.count)
            }
        }
        let imageSizeFromURL = try? imageURL?.resourceValues(forKeys: [.fileSizeKey]).fileSize
        print(info)
    }
}

