//
//  TapViewController.swift
//  TapGame
//
//  Created by roger.wang on 2017/11/21.
//  Copyright © 2017年 roger.wang. All rights reserved.
//

import UIKit
import RealmSwift

class TapViewController: UIViewController {

    private var player: RLM_User! = nil
    private var playerToken: NotificationToken?
    var name = ""
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var hitCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4
        player = self.getThePlayer(name: name)
        profileLabel.text = "\(player.name)的點擊數"
        hitCountLabel.text = "\(player.tapCount)"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 7
        playerToken = player.observe { [unowned self] changes in
            switch changes {
            case .change( _):
                self.hitCountLabel.text = "\(self.player.tapCount)"
            case .error(let error):
                print("\(error)")
            case .deleted:
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 8
        playerToken?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // 3
    func getThePlayer(name: String) -> RLM_User {
        let realm = try! Realm()
        let thePlayer = realm.objects(RLM_User.self).filter(NSPredicate(format: "name = %@", self.name)).first
        return thePlayer!
    }
    

    @IBAction func hitUpdate(_ sender: Any) {
        // 6
        DispatchQueue(label: "background").async { [unowned self] in
            let realm = try! Realm()
            let thePlayer = realm.objects(RLM_User.self).filter(NSPredicate(format: "name = %@", self.name)).first
            try! realm.write {
                thePlayer?.tapCount += 1
            }
        }
        
    }
    
    @IBAction func quit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
