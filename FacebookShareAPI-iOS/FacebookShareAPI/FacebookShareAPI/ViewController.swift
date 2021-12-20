//
//  ViewController.swift
//  FacebookShareAPI
//
//  Created by Derrick kim on 2021/12/02.
//

import UIKit
import FBSDKLoginKit
import FacebookShare

class ViewController: UIViewController, SharingDelegate {
    
    
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        debugPrint("SharingDelegate didCompleteWithResult :: " , results)
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        debugPrint("SharingDelegate Error :: ",error)
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        debugPrint("SharingDelegate DidCancel :: ", sharer)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
    }
    
    @IBAction func facebookShareBtn(_ sender: UIButton) {
        facebookSharing()
    }

    func imagePickerController(_picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            // handle and return
            return
        }
        
        let photo = SharePhoto(image: image, userGenerated: true)
        
        var content = SharePhotoContent()
        content.photos = [photo]
    }
    
    func videoPickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let video: ShareVideo

        if #available(iOS 11, *) {
            guard let videoAsset = info[.phAsset] as? PHAsset else {
                return
            }
            video = ShareVideo(videoAsset: videoAsset)
        } else {
            guard let url = info[.referenceURL] as? URL else {
                return
            }
            video = ShareVideo(videoURL: url)
        }
    }
    
    func facebookSharing() {
        guard let url = URL(string: "https://apps.apple.com/kr/app/%EB%A0%8C%ED%8A%B8%EC%B9%B4-%EC%B9%B4%EB%AA%A8%EC%95%84-1%EB%93%B1-%EB%A0%8C%ED%84%B0%EC%B9%B4-%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90/id1217310212")
        else {
            // handle and return
            return
        }
        
        let content = ShareLinkContent()
        content.contentURL = url
        
        let dialog = ShareDialog(
            fromViewController: self,
            content: content,
            delegate: self
        )
        
        dialog.show()
    }
}

