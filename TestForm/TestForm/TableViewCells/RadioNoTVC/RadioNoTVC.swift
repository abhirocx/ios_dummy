//
//  RadioNoTVC.swift
//  TestForm
//
//  Created by Shagun Verma on 02/08/20.
//  Copyright © 2020 Shagun Verma. All rights reserved.
//

import UIKit

class RadioNoTVC: UITableViewCell {

    @IBOutlet weak var btnNo: UIButton!
  var delegate:UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnNoClicked(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        (delegate as! QuestionnaireVC).captureTextFieldData(str: "false", type: SectionDataId(rawValue: self.tag) ?? .invalid)
    }
}
