//
//  ViewController.swift
//  DBSphereTagCloud
//
//  Created by Aaron Lee on 2017/10/17.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sphereView: DBSphereView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sphereView = DBSphereView(frame: CGRect(x: 0, y: 100, width: 320, height: 320))
        
        var array = [UIButton]()

        for i in 1..<50 {
            let btn = UIButton(type: UIButtonType.system)
            btn.setTitle("\(i)", for: .normal)
            btn.setTitleColor(.darkGray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
            btn.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
            btn.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
            array.append(btn)
            sphereView.addSubview(btn)
        }
        sphereView.setCloudTags(array)
        sphereView.backgroundColor = .white
        self.view.addSubview(sphereView)
    }

    @objc func buttonPressed(btn: UIButton) {
        sphereView.timerStop()
        
        UIView.animate(withDuration: 0.3, animations: {
            btn.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                btn.transform = CGAffineTransform(scaleX: 1, y: 1);
            }, completion: { _ in
                self.sphereView.timerStart()
            })
        })
    }
}

