//
//  ViewController.swift
//  DBSphereTagCloud
//
//  Created by Aaron Lee on 2017/10/17.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sphereView = DBSphereView(frame: CGRect(x: 0, y: 100, width: 320, height: 320))
//        sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
        var array = [UIButton]()
//        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        for i in 1..<50 {
//        for (NSInteger i = 0; i < 50; i ++) {
            let btn = UIButton(type: UIButtonType.system)
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.setTitle("\(i)", for: .normal)
            btn.setTitleColor(.darkGray, for: .normal)
//            [btn setTitle:[NSString stringWithFormat:@"P%ld", i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:24.];
            btn.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
//            btn.frame = CGRectMake(0, 0, 60, 20);
            btn.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
            array.append(btn)
            sphereView.addSubview(btn)
//            [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//            [array addObject:btn];
//            [sphereView addSubview:btn];
        }
        sphereView.setCloudTags(array)
        sphereView.backgroundColor = .white
        self.view.addSubview(sphereView)
//        [sphereView setCloudTags:array];
//        sphereView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:sphereView];
    }

    @objc func buttonPressed(btn: UIButton) {
        
    }


}

