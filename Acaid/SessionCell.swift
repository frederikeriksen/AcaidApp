//
//  SessionCell.swift
//  Acaid
//
//  Created by Frederik Eriksen on 28/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {
    
    let picView = UIImageView()
    let pic = UIImage()
    let titleLabel = UILabel()
    let descLabel = UILabel()

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
        
        self.picView.frame.size.height = self.contentView.frame.size.height - 2
        self.picView.frame.size.width = self.contentView.frame.size.width / 8
        self.picView.center.y = self.contentView.center.y
        self.picView.frame.origin.x = self.contentView.frame.minX + 5
        self.picView.backgroundColor = UIColor.gray
        
        self.titleLabel.frame.size.width = self.contentView.frame.size.width - self.picView.frame.maxX
        self.titleLabel.frame.size.height = self.contentView.frame.size.height / 2
        self.titleLabel.frame.origin.x = self.picView.frame.maxX
        self.titleLabel.frame.origin.y = self.contentView.frame.origin.y
        self.titleLabel.text = session.title
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.textAlignment = .center
        
        self.descLabel.frame.size.width = self.titleLabel.frame.size.width
        self.descLabel.frame.size.height = self.titleLabel.frame.size.height
        self.descLabel.frame.origin.x = self.titleLabel.frame.origin.x
        self.descLabel.frame.origin.y = self.titleLabel.frame.maxY
        self.descLabel.text = session.desc
        self.descLabel.font = UIFont.italicSystemFont(ofSize: 14)
        
        self.addSubview(picView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
    }

}
