//
//  QuestionnaireVC.swift
//  TestForm
//
//  Created by Shagun Verma on 02/08/20.
//  Copyright © 2020 Shagun Verma. All rights reserved.
//

/*{
  "section1": "ture",
  "section2": "false",
  "sectionThreeFirstRow": "\"hello\"",
  "sectionThreeSecondRow": "\"hello2\"",
  "sectionThreeThiredRow": "\"hello3\"",
  "sectionFourFirstRow": "\"helloFourFirstRow\""
}*/
import UIKit

public enum SectionDataId:Int, CaseIterable{
    case section1 = 1000
    case section2
    case sectionThreeFirstRow
    case sectionThreeSecondRow
    case sectionThreeThirdRow
    case sectionFourFirstRow
    case invalid

}
class QuestionnaireVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
 
    var isSectionOne = false
    var isSectionTwo = false

    var isSectionOneAnswerSelected = false
    var isSectionTwoAnswerSelected = false

    var isTextFieldFilled = false

    var resultsJSON = ""
    
    var dictionary : Dictionary<String,String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self

        tblView.register(UINib.init(nibName: "RadioYesTVC", bundle: nil), forCellReuseIdentifier: "RadioYesTVC")
        tblView.register(UINib.init(nibName: "RadioNoTVC", bundle: nil), forCellReuseIdentifier: "RadioNoTVC")
        tblView.register(UINib.init(nibName: "TextFieldTVC", bundle: nil), forCellReuseIdentifier: "TextFieldTVC")
        tblView.register(UINib.init(nibName: "ButtonSaveTVC", bundle: nil), forCellReuseIdentifier: "ButtonSaveTVC")

        // Do any additional setup after loading the view.
        
    }

    func captureTextFieldData(str:String, type:SectionDataId){

        switch type {
        case .section1:
            isSectionOneAnswerSelected = true
            if (str == "true"){
                isSectionOne = true
            }
            else{
                isSectionOne = false
                dictionary.removeAll()
                isTextFieldFilled = false
                isSectionTwoAnswerSelected = false
            }
            
            dictionary.updateValue(str, forKey: String(describing:type))

        case .section2:
            isSectionTwoAnswerSelected = true
             if (str == "true"){
                isSectionTwo = true
                isTextFieldFilled = false
                dictionary.removeAll()
            }
            else{
                isSectionTwo = false
            }
             
            dictionary.updateValue("true", forKey: String(describing:SectionDataId.section1))
            dictionary.updateValue(str, forKey: String(describing:type))

        default:
            isTextFieldFilled = true
            dictionary.updateValue(str, forKey: String(describing:type))

        }
        tblView.reloadData()
    }
    
    func saveClicked(){

        self.tblView.endEditing(true)
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString)
        
        let alert = UIAlertController.init(title: "Final JSON", message: jsonString, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension QuestionnaireVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (isSectionOne && (!isSectionTwo && isSectionTwoAnswerSelected)){
            return 5
        }else if (isSectionOne){
            return 3
        }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
              return 2
        case 1:
            if (isSectionOne){
                return 2
            }
            else{
                return 1
            }
        case 2:
            if (!isSectionTwo && isSectionTwoAnswerSelected){
                return 3
            }
            else{
                return 1
            }
        case 3,4:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
              return "You are in section 1"
        case 1:
            if (isSectionOne){
                return "You are in section 2"
            }else{
                return ""
            }
        case 2,3:
            if (!isSectionTwo && isSectionTwoAnswerSelected){
                return "You are in section \(section+1)"
            }
            else{
                return ""
            }
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        switch indexPath.section {
        case 0:
            if (indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "RadioYesTVC") as! RadioYesTVC
                cell.tag = SectionDataId.section1.rawValue
                cell.delegate = self
                if (isSectionOneAnswerSelected == true){
                    if (isSectionOne){
                        cell.btnYes.isSelected = true
                    }
                    else{
                        cell.btnYes.isSelected = false
                    }
                }
                return cell
            }
            else if (indexPath.row == 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "RadioNoTVC") as! RadioNoTVC
                cell.tag = SectionDataId.section1.rawValue
                cell.delegate = self
                if (isSectionOneAnswerSelected == true){
                    if (isSectionOne){
                        cell.btnNo.isSelected = false
                    }
                    else{
                        cell.btnNo.isSelected = true
                    }
                }
                
                return cell
            }
            break
        case 1:
            if (isSectionOne){
                if (indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RadioYesTVC") as! RadioYesTVC
                    cell.tag = SectionDataId.section2.rawValue
                    cell.delegate = self
                    if (isSectionTwoAnswerSelected == true){
                        if (isSectionTwo){
                            cell.btnYes.isSelected = true
                        }
                        else{
                            cell.btnYes.isSelected = false
                        }
                    }
                    
                    return cell
                }
                else if (indexPath.row == 1){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RadioNoTVC") as! RadioNoTVC
                    cell.tag = SectionDataId.section2.rawValue
                    cell.delegate = self
                    if (isSectionTwoAnswerSelected == true){
                        if (isSectionTwo){
                            cell.btnNo.isSelected = false
                        }
                        else{
                            cell.btnNo.isSelected = true
                        }
                    }
                    
                    return cell
                }
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonSaveTVC") as! ButtonSaveTVC
                cell.delegate = self
                return cell
            }
            break
        case 2:
            if (!isSectionTwo && isSectionTwoAnswerSelected){
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTVC") as! TextFieldTVC
                cell.delegate = self
                
                if (indexPath.row == 0){
                    cell.txrField.tag = SectionDataId.sectionThreeFirstRow.rawValue
                }
                else if (indexPath.row == 1){
                    cell.txrField.tag = SectionDataId.sectionThreeSecondRow.rawValue
                }else if (indexPath.row == 2){
                    cell.txrField.tag = SectionDataId.sectionThreeThirdRow.rawValue
                }
                if (!isTextFieldFilled){
                  cell.txrField.text = ""
                }
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonSaveTVC") as! ButtonSaveTVC
                cell.delegate = self
                
                return cell
            }
        case 3:
              let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTVC") as! TextFieldTVC
              cell.delegate = self
              cell.txrField.tag = SectionDataId.sectionFourFirstRow.rawValue
              
              if (!isTextFieldFilled){
                cell.txrField.text = ""
              }
              return cell
        case 4:
              let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonSaveTVC") as! ButtonSaveTVC
              cell.delegate = self
              return cell
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
}
