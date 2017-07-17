//
//  UIView.swift
//  JMSCornerRadius
//
//  Created by James on 2017/7/15.
//  Copyright © 2017年 James. All rights reserved.
//

import UIKit

private let kRCImageView: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "jms_rc_ImageView".hashValue)

public extension UIView {
    
    public func jms_rounedCorner(cornerRadius: CGFloat, rectCornerType: UIRectCorner = .allCorners, borderWidth: CGFloat = 0, borderColor: UIColor? = nil) {
        self.layoutIfNeeded()
        
        if let tempImageView = objc_getAssociatedObject(self, kRCImageView) as? UIImageView {
            tempImageView.removeFromSuperview()
        }
        
        if let tempImage = self.jms_rcImage() {
            if let newImage = self.jms_roundedCorner(image: tempImage, cornerRadius: cornerRadius, rectCornerType: rectCornerType, borderWidth: borderWidth, borderColor: borderColor) {
                let imageView = UIImageView.init(image: newImage)
                self.insertSubview(imageView, at: 0)
                self.backgroundColor = .clear
                
                objc_setAssociatedObject(self, kRCImageView, imageView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    public func jms_roundedCorner(image: UIImage, cornerRadius: CGFloat, rectCornerType: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor? = nil) -> UIImage? {
        let size = self.bounds.size
        let scale = UIScreen.main.scale
        let cornerRadii = CGSize.init(width: cornerRadius, height: cornerRadius)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let currentContext = UIGraphicsGetCurrentContext()
        if currentContext == nil {
            return nil
        }
        
        let cornerPath =  UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: rectCornerType, cornerRadii: cornerRadii)
        
        cornerPath.addClip()
        
        self.layer.render(in: currentContext!)
        self.drawBorder(path: cornerPath, borderWidth: borderWidth, borderColor: borderColor)
        
        let processedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return processedImage
    }
    
    private func drawBorder(path: UIBezierPath, borderWidth: CGFloat, borderColor: UIColor? = nil) {
        if borderWidth != 0 && borderColor != nil {
            path.lineWidth = 2 * borderWidth
            borderColor?.setStroke()
            path.stroke()
        }
    }
    
    private func jms_rcImage() -> UIImage? {
        let size = self.bounds.size
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.backgroundColor?.cgColor ?? UIColor.clear.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
