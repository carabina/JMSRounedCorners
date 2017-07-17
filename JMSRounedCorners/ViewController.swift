//
//  ViewController.swift
//  JMSRounedCorners
//
//  Created by James on 2017/7/15.
//  Copyright © 2017年 James. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.init(x: 0, y: 50, width: 80, height: 30))
        tempLabel.text = "测试"
        tempLabel.textColor = UIColor.black
        tempLabel.textAlignment = .center
        
        return tempLabel
    }()
    
    private lazy var snpkitLabel: UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.text = "Snapkit"
        tempLabel.textColor = UIColor.black
        tempLabel.textAlignment = .center

        return tempLabel
    }()
    
    private lazy var imageView: JMSRounedCornerImageView = {
        let tempImageView = JMSRounedCornerImageView.init(cornerRadius: 15, rectCornerType: .allCorners, borderWidth: 1, borderColor: .red)
//        let tempImageView = JMSRounedCornerImageView.init(frame: CGRect.init(x: 0, y: 50, width: 80, height: 30), cornerRadius: 15, rectCornerType: .allCorners, borderWidth: 1, borderColor: .red)
        tempImageView.contentMode = .scaleAspectFill
        tempImageView.clipsToBounds = true
        
        return tempImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UI
    private func setupViews() {
        /// 必须得先设置背景颜色
        self.label.backgroundColor = UIColor.red
        self.view.addSubview(self.label)
        
        var tempCenter = self.label.center
        tempCenter.x = self.view.center.x
        self.label.center = tempCenter

//        self.label.jms_rounedCorner(cornerRadius: 15)
        self.label.jms_rounedCorner(cornerRadius: 15, rectCornerType: .allCorners, borderWidth: 1, borderColor: UIColor.blue)
        
        /// Snapkit使用
        /// 必须得先设置背景颜色
        self.snpkitLabel.backgroundColor = UIColor.green
        self.view.addSubview(self.snpkitLabel)
        
        self.snpkitLabel.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
        self.snpkitLabel.jms_rounedCorner(cornerRadius: 15, rectCornerType: .allCorners, borderWidth: 1, borderColor: UIColor.blue)

        /// UIImageView
        self.view.addSubview(self.imageView)
        
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(150)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
//        self.imageView.image = UIImage.init(named: "dog")
        self.imageView.kf.setImage(with: URL.init(string: "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1500275953&di=6ce894b2972d29d8758b6b64a029196e&src=http://www.gurubear.com.cn/editor/uploadfile/20130826151723.jpg"), placeholder: UIImage.init(named: "dog"))
    }
}

