//
//  ComplexCell.swift
//  FrameRateDemo
//
//  Created by dimsky on 16/8/28.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import UIKit

class ComplexCell: UITableViewCell {
    let size = CGSize(width: 50, height: 50)

    var image1: UIImage? {
        didSet {
            imageView1.image = image1?.aspectFillImage(size: size)
        }
    }

    var image2: UIImage? {
        didSet {
            imageView2.image = image2?.aspectFillImage(size: size)
        }
    }

    var image3: UIImage? {
        didSet {
            imageView3.image = image3?.aspectFillImage(size: size)
        }
    }

    var image4: UIImage? {
        didSet {
            imageView4.image = image4?.aspectFillImage(size: size)
        }
    }

    @IBOutlet weak var imageView1: UIImageView!

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView1.layer.cornerRadius = 25
        imageView1.layer.masksToBounds = true

        imageView2.layer.cornerRadius = 25
        imageView2.layer.masksToBounds = true

        imageView3.layer.cornerRadius = 25
        imageView3.layer.masksToBounds = true

        imageView4.layer.cornerRadius = 25
        imageView4.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImage {
    func aspectFillImage(size: CGSize) -> UIImage {
        var targetSize = size
        if targetSize == CGSize(width: 0, height: 0) {
            return UIImage()
        }
        let widthRatio    = targetSize.width  / self.size.width
        let heightRatio   = targetSize.height / self.size.height
        let scalingFactor = max(widthRatio, heightRatio)
        targetSize = CGSize(width: targetSize.width / scalingFactor, height: targetSize.height / scalingFactor)
        UIGraphicsBeginImageContext(targetSize)
        let origin = CGPoint(x: (targetSize.width  - self.size.width)  / 2,
                             y: (targetSize.height - self.size.height) / 2)
        self.draw(in: CGRect(origin: origin, size: self.size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
}
