//
//  JMSRounedCornerImageView.swift
//  JMSRounedCorners
//
//  Created by James.xiao on 2017/7/17.
//  Copyright © 2017年 James. All rights reserved.
//

import UIKit

private let jms_def_Image = "image"
private let kProcessedImage: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "jms_rc_processedImage".hashValue)

public class JMSRounedCornerImageView: UIImageView {
    
    private(set) var hadAddObserver: Bool = false
    private(set) var cornerRadius: CGFloat = 0
    private(set) var rectCornerType: UIRectCorner = .allCorners
    private(set) var borderWidth: CGFloat = 0
    private(set) var borderColor: UIColor?
    private(set) var isProcessedImage: Bool = false

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(frame: CGRect = CGRect.zero, cornerRadius: CGFloat = 0, rectCornerType: UIRectCorner = .allCorners, borderWidth: CGFloat = 0, borderColor: UIColor? = nil) {
        super.init(frame: frame)
        
        self.cornerRadius = cornerRadius
        self.rectCornerType = rectCornerType
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        
        if !self.hadAddObserver {
            /// kvo
            self.addObserver(self, forKeyPath: jms_def_Image, options: .new, context: nil)
            self.hadAddObserver = true
        }
        
        self.layoutIfNeeded()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: jms_def_Image)
    }
    
    override public func jms_rounedCorner(bgColor: UIColor, cornerRadius: CGFloat, rectCornerType: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor?) {
        
    }
    
    // MARK: - KVO
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == jms_def_Image {
            if let tempImage = change?[.newKey] as? UIImage {
                if (objc_getAssociatedObject(tempImage, kProcessedImage) as? String ?? "0") != "1" {                    
                    let newImage = self.jms_roundedCorner(image: tempImage, cornerRadius: self.cornerRadius, rectCornerType: self.rectCornerType, borderWidth: self.borderWidth, borderColor: self.borderColor)
                    
                    if newImage != nil {
                        objc_setAssociatedObject(newImage, kProcessedImage, "1", .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    }
                    
                    self.image = newImage
                }
            }
        }
    }

}
