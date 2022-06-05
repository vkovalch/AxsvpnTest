//
//  StartVC.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 03.06.2022.
//

import UIKit

class StartVC: UIViewController {

    //MARK: - Actions
    @IBAction func toVariantOne(_ sender: Any) {
        let vc = Utils.getViewController(.main, .program)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toVariantThree(_ sender: Any) {
        let vc = Utils.getViewController(.main, .map)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Select Variant"
    }

}

