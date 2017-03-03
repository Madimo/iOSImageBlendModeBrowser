//
//  ImageBlendMode.swift
//  BlendModeBrowser
//
//  Created by Madimo on 2017/3/3.
//  Copyright © 2017年 Madimo. All rights reserved.
//

import UIKit

struct ImageBlendMode {

    var name: String
    var blendMode: CGBlendMode

    init(name: String, blendMode: CGBlendMode) {
        self.name = name
        self.blendMode = blendMode
    }

}

extension ImageBlendMode: Equatable {

    static func ==(lhs: ImageBlendMode, rhs: ImageBlendMode) -> Bool {
        return lhs.name == rhs.name
    }

}
