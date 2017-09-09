//
//  ViewController.swift
//  BackgroundTestProject
//
//  Created by FromF on 2017/09/09.
//  Copyright © 2017年 FromF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    ///アラート表示していいか？
    var isPopUpAlertView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //バックグラウンド通知設定
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(viewWillResignActive(_:)),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(viewDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
    }

    deinit {
        //バックグラウンド通知解除
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func yahooButtonAction(_ sender: Any) {
        if let openURL = URL(string: "http://yahoo.co.jp") {
            //アラート表示するためにフラグをONにする
            isPopUpAlertView = true
            //Safariを起動する
            UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
        }
    }

    // MARK: - Notification
    //バックグラウンド通知
    func viewWillResignActive(_ notification: Notification?) {
        print("非アクティブになった")
    }
    
    func viewDidBecomeActive(_ notification: Notification?) {
        print("アクティブになった")
        if isPopUpAlertView {
            //１回表示したから２回目表示しないようにフラグをOFFにする
            isPopUpAlertView = false
            //アラート表示する
            //ダイアログを作成
            let alertController = UIAlertController(title: "確認", message: "Yahoo!Japanは見えましたか？", preferredStyle: .alert)
            //ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("OKタップ")
            })
            //アクションを追加
            alertController.addAction(defaultAction)
            //ダイアログの表示
            present(alertController, animated: true, completion: nil)

        }
    }
}

