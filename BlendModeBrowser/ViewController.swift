//
//  ViewController.swift
//  BlendModeBrowser
//
//  Created by Madimo on 2017/3/3.
//  Copyright © 2017年 Madimo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var sourceImageAlphaLabel: UILabel!
    @IBOutlet weak var sourceImageAlphaSlider: UISlider!
    @IBOutlet weak var blendImageAlphaLabel: UILabel!
    @IBOutlet weak var blendImageAlphaSlide: UISlider!
    @IBOutlet weak var blendModeButton: UIButton!

    fileprivate var sourceImage = #imageLiteral(resourceName: "source") {
        didSet {
            if sourceImage != oldValue {
                reloadImage()
            }
        }
    }

    fileprivate var blendImage = #imageLiteral(resourceName: "blend") {
        didSet {
            if blendImage != oldValue {
                reloadImage()
            }
        }
    }

    fileprivate var blendedImage: UIImage? {
        didSet {
            previewImageView.image = blendedImage
        }
    }

    fileprivate var blendMode: ImageBlendMode = BlendModeTableViewController.blendModes.first! {
        didSet {
            if blendMode != oldValue {
                blendModeButton.setTitle("Blend Mode: \(blendMode.name)", for: .normal)
                reloadImage()
            }
        }
    }

    fileprivate var sourceImagePicker: UIImagePickerController?
    fileprivate var blendImagePicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadImage()
    }

    func reloadImage() {
        let rect = CGRect(origin: .zero, size: sourceImage.size)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        sourceImage.draw(at: .zero, blendMode: .normal, alpha: CGFloat(sourceImageAlphaSlider.value))
        blendImage.draw(in: rect, blendMode: blendMode.blendMode, alpha: CGFloat(blendImageAlphaSlide.value))
        blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    // MARK: - Actions

    @IBAction func onChooseSourceImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        sourceImagePicker = controller
        present(controller, animated: true, completion: nil)
    }

    @IBAction func onChooseBlendImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        blendImagePicker = controller
        present(controller, animated: true, completion: nil)
    }

    @IBAction func onSourceImageAlphaChanged(_ sender: Any) {
        let text = String(format: "Alpha: %.2f", sourceImageAlphaSlider.value)
        sourceImageAlphaLabel.text = text
    }

    @IBAction func onBlendImageAlphaChanged(_ sender: Any) {
        let text = String(format: "Alpha: %.2f", blendImageAlphaSlide.value)
        blendImageAlphaLabel.text = text
    }

    @IBAction func onSourceImageAlphaEditingEnd(_ sender: Any) {
        reloadImage()
    }

    @IBAction func onBlendImageAlphaEditingEnd(_ sender: Any) {
        reloadImage()
    }

    @IBAction func onImageViewTapped(_ sender: Any) {
        guard let image = blendedImage else { return }

        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Save Image", style: .default) { _ in
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        })
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(controller, animated: true, completion: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBlendModeList", let controller = segue.destination as? BlendModeTableViewController {
            controller.popoverPresentationController?.delegate = self
            controller.delegate = self
            controller.selectedBlendMode = blendMode
        }
    }

}

// MARK: - UIImagePickerController

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if picker == sourceImagePicker {
                sourceImage = image
            } else {
                blendImage = image
            }
        }

        sourceImagePicker = nil
        blendImagePicker = nil

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

// MARK: - BlendModeTableViewControllerDelegate

extension ViewController: BlendModeTableViewControllerDelegate {

    func blendModeTableViewController(_ controller: BlendModeTableViewController, didSelectBlendMode blendMode: ImageBlendMode) {
        self.blendMode = blendMode
        controller.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UIPopoverPresentationControllerDelegate

extension ViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}

