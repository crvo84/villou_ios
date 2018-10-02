//
//  SceneTransitionType.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    case root(animated: Bool)
    case push
    case modal(style: UIModalTransitionStyle)
}
