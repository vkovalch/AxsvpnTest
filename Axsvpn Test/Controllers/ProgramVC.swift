//
//  ProgramVC.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import UIKit

class ProgramVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let cellName: String = "programCell"
    var programs: [Program] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var refreshControl: UIRefreshControl!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Programs"
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.tableView.refreshControl = refreshControl
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        loadData{ _ in }
    }
    
    //MARK: - Methods
    private func loadData(_ completion: @escaping (Bool) -> Void) {
        API.shared.getMediaLibrary { media, err in
            if let err = err {
                //let error
                let alert = UIAlertController(
                    title: "Error",
                    message: (err as? ErrorModel)?.message ?? "Something went wrong",
                    preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: UIAlertAction.Style.destructive,
                                              handler: {(_: UIAlertAction!) in
                    completion(false)
                }
                                             ))
                self.present(alert, animated: true)
            } else {
                StaticStorage.shared.media = media
                self.programs = media!.programs
                completion(true)
            }
        }
    }
    
    //MARK: - Objc Methods
    @objc private func refresh() {
        loadData() { res in
            self.refreshControl.endRefreshing()
        }
    }
}

extension ProgramVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let program = self.programs[indexPath.row]
        let vc = Utils.getViewController(.main, .programDetail) as! ProgramDetailVC
        vc.program = program
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProgramVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as! ProgramCell
        let item = programs[indexPath.row]
        cell.fillData(item)
        cell.selectionStyle = .none
        return cell
    }
    
}
