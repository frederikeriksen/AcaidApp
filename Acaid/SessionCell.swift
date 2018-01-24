//
//  SessionCell.swift
//  Acaid
//
//  Created by Frederik Eriksen on 28/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class SessionCell: UITableViewCell {
    
    let picView = UIImageView()
    let pic = UIImage()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let ratingView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(session: Session) {
    
        self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        self.contentView.layer.cornerRadius = 50
        self.contentView.layer.masksToBounds = true

        self.picView.frame.size.height = self.contentView.frame.size.height / 2
        self.picView.frame.size.width = self.picView.frame.size.height
        self.picView.frame.origin.y = self.contentView.frame.origin.y
        self.picView.frame.origin.x = self.contentView.frame.minX + 5
        self.picView.backgroundColor = UIColor.gray
        
        self.titleLabel.frame.size.width = self.contentView.frame.size.width - self.picView.frame.maxX
        self.titleLabel.frame.size.height = self.contentView.frame.size.height / 2
        self.titleLabel.frame.origin.x = self.picView.frame.maxX + 20
        self.titleLabel.frame.origin.y = self.contentView.frame.origin.y
        self.titleLabel.text = session.title
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.textAlignment = .center
        
        self.descLabel.frame.size.width = self.titleLabel.frame.size.width
        self.descLabel.frame.size.height = self.titleLabel.frame.size.height
        self.descLabel.frame.origin.x = self.titleLabel.frame.origin.x
        self.descLabel.frame.origin.y = self.titleLabel.frame.maxY
        self.descLabel.text = session.desc
        self.descLabel.font = UIFont.italicSystemFont(ofSize: 14)
        self.descLabel.textAlignment = .center
        
        self.ratingView.frame.size.width = self.titleLabel.frame.minX
        self.ratingView.frame.size.height = self.contentView.frame.size.height / 2
        self.ratingView.frame.origin.x = self.picView.frame.origin.x
        self.ratingView.frame.origin.y = self.picView.frame.maxY
        self.ratingView.image = UIImage(named: "defaultRating")
        
        if(session.tutorRating == 1){
            ratingView.image = UIImage(named: "defaultRating")
        } else if(session.tutorRating > 1 && session.tutorRating <= 2) {
            ratingView.image = UIImage(named: "oneRating")
        } else if(session.tutorRating > 2 && session.tutorRating <= 3) {
            ratingView.image = UIImage(named: "twoRating")
        } else if(session.tutorRating > 3 && session.tutorRating <= 4) {
            ratingView.image = UIImage(named: "threeRating")
        } else if(session.tutorRating > 4 && session.tutorRating <= 5) {
            ratingView.image = UIImage(named: "fourRating")
        } else if(session.tutorRating > 5 && session.tutorRating <= 6) {
            ratingView.image = UIImage(named: "fiveRating")
        } else if(session.tutorRating > 6 && session.tutorRating <= 7) {
            ratingView.image = UIImage(named: "sixRating")
        } else if(session.tutorRating > 7 && session.tutorRating <= 8) {
            ratingView.image = UIImage(named: "sevenRating")
        } else if(session.tutorRating > 8 && session.tutorRating <= 9) {
            ratingView.image = UIImage(named: "eightRating")
        } else if(session.tutorRating > 9 && session.tutorRating <= 10) {
            ratingView.image = UIImage(named: "nineRating")
        } else if(session.tutorRating > 10 && session.tutorRating <= 11) {
            ratingView.image = UIImage(named: "tenRating")
        } else if(session.tutorRating == 0) {
            ratingView.image = nil
        }
        
        self.addSubview(picView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(ratingView)
        
        if session.pressedBy == "none" {
            titleLabel.text = session.title
        } else if session.pressedBy != "none" && session.pressedBy != Auth.auth().currentUser?.uid {
            titleLabel.text = session.title + "   (occupied)"
        }
        
        if session.wasAccepted == "active" {
            if session.pressedBy != Auth.auth().currentUser?.uid {
                titleLabel.text = session.title + "   (occupied)"
            } else if session.pressedBy == Auth.auth().currentUser?.uid {
                titleLabel.text = session.title + "   (accepted!)"
                titleLabel.textColor = UIColor.green
            }
        }
    }

}
