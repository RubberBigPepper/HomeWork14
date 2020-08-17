//
//  ViewController.swift
//  HomeWork14
//
//  Created by Albert on 13.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)//вид покажется, поднимаем сохраненные данные
        nameTextField.text = Persistance.shared.userName
        secondNameTextField.text = Persistance.shared.userSecondName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)//вид скроется - сохраняем данные
        Persistance.shared.userName = nameTextField.text
        Persistance.shared.userSecondName = secondNameTextField.text
    }


}

