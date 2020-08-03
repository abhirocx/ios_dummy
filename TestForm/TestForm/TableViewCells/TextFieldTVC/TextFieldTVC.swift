//
//  TextFieldTVC.swift
//  TestForm
//
//  Created by Shagun Verma on 02/08/20.
//  Copyright © 2020 Shagun Verma. All rights reserved.
//

import UIKit

class TextFieldTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txrField: UITextField!
    var delegate:UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txrField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard delegate != nil else {
            return
        }
        (delegate as! QuestionnaireVC).captureTextFieldData(str: textField.text ?? "", type: SectionDataId(rawValue: textField.tag) ?? .invalid)
    }
    
}
