//
//  ViewController.swift
//  TapGame
//
//  Created by roger.wang on 2017/11/21.
//  Copyright © 2017年 roger.wang. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var responseLbl: UILabel!
    
    var player: RLM_User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseLbl.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // 1
    func writeUserData() {
        // 檢查userNameTextField,解optional
        guard let name = self.userNameTextField.text else {
            return
        }

        // 取得一個 realm instance
        let realm = try! Realm()

        // 檢查是否有重複的 name
        let sameNamePredicate = NSPredicate(format: "name = %@", name)
        let res = realm.objects(RLM_User.self).filter(sameNamePredicate)
        if res.count != 0 {
            player = res.first
            return
        }

        // 建立 user instance
        let user = RLM_User(name: name)

        // 寫入realm
        try! realm.write {
            realm.add(user)
        }
        player = user
    }
    
    @IBAction func playClicked(_ sender: Any) {
        // 2
        self.writeUserData()
        responseLbl.text = "嗨！ \(player.name) 歡迎來玩！"
        responseLbl.isHidden = false

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TapViewController") as! TapViewController
        // 5
        vc.name = player.name
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        // 9
        // 檢查userNameTextField有沒有值,解optional
        guard let name = self.userNameTextField.text else {
            return
        }

        let realm = try! Realm()
        if let player = realm.objects(RLM_User.self)
            .filter(NSPredicate(format: "name = %@", name)).first {
            try! realm.write {
                realm.delete(player)
            }
        }
        
    }
    
}

