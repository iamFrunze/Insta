//
//  IGFeedPostTableViewCell.swift
//  Insta
//
//  Created by Антон Коротков on 08.02.2022.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {

  static let identifier = "IGFeedPostTableViewCell"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure() {
    // configure for cell
    
  }
}
