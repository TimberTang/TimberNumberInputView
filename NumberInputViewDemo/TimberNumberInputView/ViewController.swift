//
//  ViewController.swift
//  TimberNumberInputView
//
//  Created by TimberTang on 2017/8/23.
//  Copyright © 2017年 TimberTang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textField = UITextField(frame: CGRect(x: 100, y: 200, width: 200, height: 30))
        textField.inputView = NumberInputView(keyInput: textField)
        self.view.addSubview(textField)
    }


}

