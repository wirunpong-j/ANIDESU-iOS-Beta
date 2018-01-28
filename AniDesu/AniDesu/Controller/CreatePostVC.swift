//
//  CreatePostVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 28/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Kingfisher

class CreatePostVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var profileImageView: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusTextView.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreatePostVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        setUpView()
    }
    
    func setUpView() {
        let url = URL(string: UserDataService.instance.imageUrlProfile)
        profileImageView.kf.setImage(with: url)
        nameLabel.text = UserDataService.instance.displayName
        aboutLabel.text = UserDataService.instance.about
        statusTextView.textColor = UIColor.lightGray
        statusTextView.text = "What's on your mind?"
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            shareBtn.isEnabled = false
        } else {
            shareBtn.isEnabled = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind?"
            textView.textColor = UIColor.lightGray
        }
    }
}
