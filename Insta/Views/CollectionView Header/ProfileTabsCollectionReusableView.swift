//
//  ProfileTabsCollectionReusableView.swift
//  Insta
//
//  Created by Антон Коротков on 09.02.2022.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
  static let identifier = "ProfileTabsCollectionReusableView"

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
