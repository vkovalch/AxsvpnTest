//
//  ProgramCell.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import UIKit
import Kingfisher

class ProgramCell: UITableViewCell {

    
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(_ item: Program) {
        callImage.layer.cornerRadius = 8
        callImage.kf.indicatorType = .activity
        callImage.kf.setImage(with: URL(string: item.cover.url))
        cellTitle.text = item.title        
    }
    
}
