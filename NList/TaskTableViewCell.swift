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
    
    @IBOutlet weak var CheckMarkButton: UIButton!
    public var tableViewController : TaskListTableViewController?;
    public var cellIndexPath : IndexPath?;
    
    @IBAction func CheckBoxTapped(_ sender: UIButton) {
        tableViewController?.rowCheckMarkButtonClicked(at: cellIndexPath!)
//        sender.isSelected = !sender.isSelected;
    }
    func SetCheckMarkedState(state : Bool){
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.fade
        CheckMarkButton.layer.add(animation, forKey: nil);
        
        if(!state){
            UIView.animate(withDuration: 0.2, animations: {
                self.CheckMarkButton.setBackgroundImage(UIImage(named:"CheckMarkNotFilled"), for: .normal);
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.CheckMarkButton.setBackgroundImage(UIImage(named:"CircleNotFilled"), for: .normal);
            })
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)));
        self.addGestureRecognizer(tap);

    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        tableViewController?.rowCheckMarkButtonClicked(at: cellIndexPath!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
