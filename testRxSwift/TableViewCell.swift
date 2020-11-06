//
//  TableViewCell.swift
//  testRxSwift
//
//  Created by PAPADA PREEDAGORN on 6/11/2563 BE.
//  Copyright © 2563 PAPADA PREEDAGORN. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
  @IBOutlet weak var imageCar: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  static let nibName = "TableViewCell"
  static let cellIdentifier = "TableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func updateUI(item: Article) {
    guard let urlImage = URL(string: item.image) else { return }
    imageCar.kf.setImage(with: urlImage)
    titleLabel.text = item.title
    dateTimeLabel.text = item.dateTime
    guard let descriptionText = item.content.first?.description else {
      return
    }
    descriptionLabel.text = descriptionText
  }
  
}
