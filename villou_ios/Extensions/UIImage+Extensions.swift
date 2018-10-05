//
//  UIImage+Extensions.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 9/30/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with urlStr: String?, placeholder: UIImage? = nil) {
        setImage(with: URL(string: urlStr), placeholder: placeholder)
    }

    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}

private extension URL {
    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(string: string)
    }
}
