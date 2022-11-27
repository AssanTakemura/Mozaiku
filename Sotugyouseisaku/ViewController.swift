//
//  ViewController.swift
//  Sotugyouseisaku
//
//  Created by 竹村明日香 on 2022/11/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    画像を入れる場所を準備
    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage: UIImage!
    
    var filter: CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        let myInputUIImage: UIImage = UIImage(ciImage: myInputImage)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        cameraImageView.image = info[.editedImage] as? UIImage
        
        originalImage = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    //    写真選ぶボタン
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    //    画像保存ボタン
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    
    //    画像をモザイク化するボタン
    @IBAction func Mozaiku(){
        let myInputImage = CIImage(image: originalImage)!
        
        var myPixellateFilter = CIFilter(name: "CIPixellate")
        
        myPixellateFilter!.setValue(myInputImage, forKey: kCIInputImageKey)
        
        let myOutputImage : CIImage = myPixellateFilter!.outputImage!
        let myOutputUIImage: UIImage = UIImage(ciImage: myOutputImage)
        
        //    ImageViewに再度画像を入れる
        cameraImageView.image = myOutputUIImage
        cameraImageView.setNeedsDisplay()
        
    }
    
    //    カメラで画像を撮影
    @IBAction func takePhoto(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated:  true, completion: nil)
        } else {
            print("error")
        }
        
    }
    
}



