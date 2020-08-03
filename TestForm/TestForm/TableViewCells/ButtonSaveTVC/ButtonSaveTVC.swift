//
//  ButtonSaveTVC.swift
//  TestForm
//
//  Created by Shagun Verma on 03/08/20.
//  Copyright © 2020 Shagun Verma. All rights reserved.
//

import UIKit

class ButtonSaveTVC: UITableViewCell {

    @IBOutlet weak var btnSave: UIButton!
    var delegate:UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        guard delegate != nil else {
            return
        }
        (delegate as! QuestionnaireVC).saveClicked()
    }
}
