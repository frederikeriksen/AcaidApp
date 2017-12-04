//
//  BookCell.swift
//  Acaid
//
//  Created by Frederik Eriksen on 04/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let courseLabel = UILabel()
    let semesterLabel = UILabel()

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
    
    func configureCell(book: Book) {
        
        self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        
        self.titleLabel.text = book.title
        self.titleLabel.textAlignment = .center
        self.titleLabel.frame.origin.x = contentView.frame.origin.x
        self.titleLabel.frame.origin.y = contentView.frame.origin.y
        self.titleLabel.frame.size.height = contentView.frame.size.height / 2
        self.titleLabel.frame.size.width = contentView.frame.size.width
        
        self.courseLabel.text = book.course
        self.courseLabel.textAlignment = .center
        self.courseLabel.frame.origin.x = contentView.frame.origin.x
        self.courseLabel.frame.origin.y = contentView.center.y
        self.courseLabel.frame.size.height = contentView.frame.size.height / 2
        self.courseLabel.frame.size.width = contentView.frame.size.width / 2
        
        self.semesterLabel.text = book.semester
        self.semesterLabel.textAlignment = .center
        self.semesterLabel.frame.origin.x = contentView.center.x
        self.semesterLabel.frame.origin.y = contentView.center.y
        self.semesterLabel.frame.size.height = courseLabel.frame.size.height
        self.semesterLabel.frame.size.width = courseLabel.frame.size.width
        
        self.addSubview(titleLabel)
        self.addSubview(courseLabel)
        self.addSubview(semesterLabel)
    }

}
