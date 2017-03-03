//
//  BlendModeTableViewController.swift
//  BlendModeBrowser
//
//  Created by Madimo on 2017/3/3.
//  Copyright © 2017年 Madimo. All rights reserved.
//

import UIKit

protocol BlendModeTableViewControllerDelegate: class {
    func blendModeTableViewController(_ controller: BlendModeTableViewController, didSelectBlendMode blendMode: ImageBlendMode)
}

class BlendModeTableViewController: UITableViewController {

    private(set) static var blendModes: [ImageBlendMode] = {
        let modes = [
            ImageBlendMode(name: "normal", blendMode: .normal),
            ImageBlendMode(name: "multiply", blendMode: .multiply),
            ImageBlendMode(name: "screen", blendMode: .screen),
            ImageBlendMode(name: "overlay", blendMode: .overlay),
            ImageBlendMode(name: "darken", blendMode: .darken),
            ImageBlendMode(name: "lighten", blendMode: .lighten),
            ImageBlendMode(name: "colorDodge", blendMode: .colorDodge),
            ImageBlendMode(name: "colorBurn", blendMode: .colorBurn),
            ImageBlendMode(name: "softLight", blendMode: .softLight),
            ImageBlendMode(name: "hardLight", blendMode: .hardLight),
            ImageBlendMode(name: "difference", blendMode: .difference),
            ImageBlendMode(name: "exclusion", blendMode: .exclusion),
            ImageBlendMode(name: "hue", blendMode: .hue),
            ImageBlendMode(name: "saturation", blendMode: .saturation),
            ImageBlendMode(name: "color", blendMode: .color),
            ImageBlendMode(name: "luminosity", blendMode: .luminosity),
            ImageBlendMode(name: "clear", blendMode: .clear),
            ImageBlendMode(name: "copy", blendMode: .copy),
            ImageBlendMode(name: "sourceIn", blendMode: .sourceIn),
            ImageBlendMode(name: "sourceOut", blendMode: .sourceOut),
            ImageBlendMode(name: "sourceAtop", blendMode: .sourceAtop),
            ImageBlendMode(name: "destinationOver", blendMode: .destinationOver),
            ImageBlendMode(name: "destinationIn", blendMode: .destinationIn),
            ImageBlendMode(name: "destinationOut", blendMode: .destinationOut),
            ImageBlendMode(name: "destinationAtop", blendMode: .destinationAtop),
            ImageBlendMode(name: "xor", blendMode: .xor),
            ImageBlendMode(name: "plusDarker", blendMode: .plusDarker),
            ImageBlendMode(name: "plusLighter", blendMode: .plusLighter),
        ]
        return modes
    }()

    weak var delegate: BlendModeTableViewControllerDelegate?
    var selectedBlendMode: ImageBlendMode?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let mode = selectedBlendMode {
            if let index = BlendModeTableViewController.blendModes.index(of: mode) {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
            }
        }
    }

    // MARK: - UITableViewDataSource & UITableViewDelegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BlendModeTableViewController.blendModes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlendModeTableViewCell", for: indexPath) as! BlendModeTableViewCell
        let blendMode = BlendModeTableViewController.blendModes[indexPath.row]
        cell.blendMode = blendMode
        cell.accessoryType = blendMode == selectedBlendMode ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBlendMode = BlendModeTableViewController.blendModes[indexPath.row]
        tableView.reloadData()

        delegate?.blendModeTableViewController(self, didSelectBlendMode: selectedBlendMode!)
    }

}
