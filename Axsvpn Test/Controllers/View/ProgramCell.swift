//
//  ProgramCell.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import UIKit
import Kingfisher

class ProgramCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    func fillData(_ item: Program) {
        callImage.layer.cornerRadius = 8
        callImage.kf.indicatorType = .activity
        callImage.kf.setImage(with: URL(string: item.cover.url))
        cellTitle.text = item.title        
    }
    
}
