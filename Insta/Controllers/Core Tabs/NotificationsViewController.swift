//
//  NotificationsViewController.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.title = ""
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    navigationController?.navigationBar.topItem?.title = "Notifications"

    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }

}
