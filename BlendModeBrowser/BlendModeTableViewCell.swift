//
//  BlendModeTableViewCell.swift
//  BlendModeBrowser
//
//  Created by Madimo on 2017/3/3.
//  Copyright © 2017年 Madimo. All rights reserved.
//

import UIKit

class BlendModeTableViewCell: UITableViewCell {

    var blendMode: ImageBlendMode? {
        didSet {
            guard let blendMode = blendMode else { return }

            nameLabel.text = blendMode.name
        }
    }

    @IBOutlet weak var nameLabel: UILabel!

}
