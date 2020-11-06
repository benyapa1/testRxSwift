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
  private var data: Content?
  private var error: Error?
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    callingAPI()
  }
  
  func setupTableView() {
    tableView.register(UINib(nibName: TableViewCell.nibName, bundle: Bundle(for: TableViewCell.self)), forCellReuseIdentifier: TableViewCell.cellIdentifier)
  }
  
  func callingAPI() {
    let receiveDataResult = getData(url, parameters: nil)
    _ = receiveDataResult.subscribe(onNext: { [weak self] (value) in
      self?.data = value
      self?.tableView.reloadData()
    }, onError: { [weak self] (error) in
      self?.error = error
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

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data?.content.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell, let dataCell = data?.content[indexPath.row] else {
      return UITableViewCell()
    }
    cell.updateUI(item: dataCell)
    return cell
  }
  
  
}

