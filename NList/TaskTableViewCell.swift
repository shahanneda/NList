//
//  TaskTableViewCell.swift
//  NList
//
//  Created by Shahan Nedadahandeh on 2020-04-01.
//  Copyright © 2020 Shahan Nedadahandeh. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    

    @IBOutlet weak var ContentLabel: UILabel!
   
    
    @IBAction func CheckBoxTapped(_ sender: UIButton) {
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.fade
        
        sender.layer.add(animation, forKey: nil);
        if(!sender.isSelected){
            UIView.animate(withDuration: 0.2, animations: {
                sender.setBackgroundImage(UIImage(named:"CheckMarkNotFilled"), for: .normal);
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                sender.setBackgroundImage(UIImage(named:"CircleNotFilled"), for: .normal);
            })
        }
        sender.isSelected = !sender.isSelected;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
