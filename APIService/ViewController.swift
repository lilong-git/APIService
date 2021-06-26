//
//  ViewController.swift
//  APIService
//
//  Created by Simon on 2021/3/11.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.request1()
        
        self.request2()
     
    }
    
    func request1() {
        API.Discover.index.requestArray(BaseResponse.self).asObservable().subscribe(onNext: { (models) in
            
        })
    }
    
    ///聚合
    func request2() {
        let indexReqeust =  API.Discover.index.requestArray(BaseResponse.self).asObservable()
        let bannerRequest = API.Discover.banner.requestArray(BaseResponse.self).asObservable()
        Observable.zip(indexReqeust, bannerRequest).subscribe(onNext: { (sections,banners) in
            
        })
    }
}

