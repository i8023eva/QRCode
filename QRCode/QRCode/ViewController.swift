//
//  ViewController.swift
//  QRCode
//
//  Created by 李元华 on 2019/5/13.
//  Copyright © 2019 李元华. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var QRView: NSImageView!
    @IBOutlet weak var centerButton: NSButton! {
        didSet {
            centerButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func generatorQR(_ sender: NSButton) {
        centerButton.isHidden = false
        
        let text = textView.string
        
        //        创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // MAC OS
        //        filter?.setDefaults()
        
        let data = text.data(using: .utf8)
        filter?.setValue(data, forKey: "inputMessage")
        //        纠错率   L M  Q   H  识别度高，扫描时间长
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        guard var imageTmp = filter?.outputImage else {return}
        
        //        转换高清图片
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        imageTmp = imageTmp.transformed(by: transform)
        
        guard let cgImage = CGImageRefFromCIImage(image: imageTmp) else { return }
        
        let imageResult = NSImage(cgImage: cgImage, size: NSSize(width: 200.0, height: 200.0))
        
        QRView.image = imageResult
    }

    // CIImage 转换为 CGImageRef
    private func CGImageRefFromCIImage(image: CIImage) -> CGImage? {
        let ciContext = CIContext(options: [:])
        let cgImage = ciContext.createCGImage(image, from: image.extent)
        
        return cgImage
    }
    
    @IBAction func detectorQR(_ sender: NSButton) {
        
    }
    
    @IBAction func getSystemImage(_ sender: NSButton) {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        //可以选择的格式
        panel.allowedFileTypes = ["png", "jpeg", "jpg"]
        panel.allowsOtherFileTypes = false

//        panel.prompt = "选择"
        panel.title = "选择图片"
        
//        let cancelButton = panel.value(forKey: "_cancelButton") as! NSButton
//        cancelButton.title = "取消"
        
        
        panel.beginSheetModal(for: view.window!) { (Response) in
            if Response == .OK {
                guard let path = panel.urls.first?.path else { return }
                let image = NSImage(contentsOfFile: path)
                image?.size = NSSize(width: 50, height: 50)
                sender.image = image
            }
            
        }
    }
    
}

