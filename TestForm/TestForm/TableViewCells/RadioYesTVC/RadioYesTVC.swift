//
//  RadioYesTVC.swift
//  TestForm
//
//  Created by Shagun Verma on 02/08/20.
//  Copyright © 2020 Shagun Verma. All rights reserved.
//

import UIKit

class RadioYesTVC: UITableViewCell {

    @IBOutlet weak var btnYes: UIButton!
    var delegate:UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnYesClicked(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        (delegate as! QuestionnaireVC).captureTextFieldData(str: "true", type: SectionDataId(rawValue: self.tag) ?? .invalid)
    }
}
