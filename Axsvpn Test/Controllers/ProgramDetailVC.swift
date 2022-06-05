//
//  ProgramDetailVC.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import UIKit
import Kingfisher

class ProgramDetailVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //MARK: - Properties
    let cellName = "trackCell"
    var program: Program?
    var tracks: [Track] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableViewHeight.constant = CGFloat(61 * tracks.count)
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let program = program else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let urlString = program.cover.resolutions.filter({$0.size == 250}).first?.url ?? program.cover.url
        if let url = URL(string: urlString) {
            self.bannerImage.kf.indicatorType = .activity
            self.bannerImage.kf.setImage(with: url)
        }
        self.titleLabel.text = program.title
        self.descLabel.attributedText = (program.descriptionHTML ?? "No Decription").htmlToAttributedString
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tracks = program!.tracks
    }
    
}

extension ProgramDetailVC: UITableViewDelegate {
    
}

extension ProgramDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! TrackCell
        let item = tracks[indexPath.row]
        cell.url = item.media.mp3.url
        cell.trackTitle.text = item.title
        cell.selectionStyle = .none
        return cell
    }
    
    
}
