//
//  UIScrollView+Extensions.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/28/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

extension UIScrollView {
    func isNearBottom(offset: CGFloat = 20.0) -> Bool {
        return contentOffset.y + frame.size.height + offset > contentSize.height
    }
}
