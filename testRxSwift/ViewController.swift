//
//  ViewController.swift
//  testRxSwift
//
//  Created by PAPADA PREEDAGORN on 2/10/2563 BE.
//  Copyright © 2563 PAPADA PREEDAGORN. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

enum MyError: Error {
  case pang(String)
}

class ViewController: UIViewController {
  
  private let url = "https://www.apphusetreach.no/application/119267/article/get_articles_list"

  override func viewDidLoad() {
    super.viewDidLoad()
    callingAPI()
  }
  
  func callingAPI() {
    let receiveDataResult = getData(url, parameters: nil)
    _ = receiveDataResult.subscribe(onNext: { (value) in
      print(value)
    }, onError: { (error) in
      print(error)
    })
  }
  
  func getData(_ url: String, parameters: [String:String]?) -> Observable<Content> {
    return Observable<Content>.create { (observer) -> Disposable in
      AF.request(url,
      method: .get,
      parameters: parameters
      ).responseJSON { (response) in
        switch response.result {
        case .success(_):
          guard let data = response.data else { return }
          do {
            let resp = try JSONDecoder().decode(Content.self, from: data)
            observer.onNext(resp)
          } catch (let error) {
            observer.onError(error)
          }
        case .failure(let error):
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }


}

