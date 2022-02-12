//
//  ViewController.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    // Do any additional setup after loading the view.
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    handleNotAuthenticated()

  }

  private func handleNotAuthenticated() {
    //Check auth status
    if Auth.auth().currentUser == nil {
      //Show log in
      let loginVC = LoginViewController()
      loginVC.modalPresentationStyle = .fullScreen
      present(loginVC, animated: false)
    }
  }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath)
    return cell
  }


}
