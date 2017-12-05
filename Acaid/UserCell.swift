//
//  UserCell.swift
//  Acaid
//
//  Created by Frederik Eriksen on 05/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    let picView = UIImageView()
    let nameView = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(user: User) {
    
        self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        
        picView.frame.size.height = contentView.frame.size.height - 2
        picView.frame.size.width = contentView.frame.size.height
        picView.frame.origin.x = contentView.frame.origin.x + 10
        picView.center.y = contentView.center.y
        picView.backgroundColor = UIColor.gray
        self.addSubview(picView)
        
        nameView.frame.size.height = contentView.frame.size.height - 2
        nameView.frame.size.width = contentView.frame.size.width - picView.frame.maxX
        nameView.frame.origin.x = picView.frame.maxX
        nameView.center.y = contentView.center.y
        nameView.text = user.firstName + " " + user.lastName
        nameView.textAlignment = .center
        self.addSubview(nameView)
        
    }

}
