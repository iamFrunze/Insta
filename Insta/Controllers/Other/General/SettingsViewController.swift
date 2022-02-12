//
//  SettingsViewController.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import UIKit
import SafariServices

struct SettingsCellModel {
  let title: String
  let handler: (() -> Void)
}

///View Controller to show user settings
final class SettingsViewController: UIViewController {

  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  private var data = [[SettingsCellModel]]()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  private func configureModels() {

    data.append([
      SettingsCellModel(title: "Edit Profile") { [weak self] in
        self?.didTapEditProfile()
      },
      SettingsCellModel(title: "Invite friends") { [weak self] in
        self?.didTapInviteFriends()
      },
      SettingsCellModel(title: "Save original posts") { [weak self] in
        self?.didTapSaveOriginalPosts()
      }
    ])

    data.append([
      SettingsCellModel(title: "Terms of Serivce") { [weak self] in
        self?.didTapOpenUrl(type: .terms)
      },
      SettingsCellModel(title: "Privacy Policy") { [weak self] in
        self?.didTapOpenUrl(type: .privacy)
      },
      SettingsCellModel(title: "Help / Feedback") { [weak self] in
        self?.didTapOpenUrl(type: .help)
      }
    ])

    data.append([
      SettingsCellModel(title: "Log Out") { [weak self] in
        self?.didTapLogOut()
      }
    ])

  }

  enum SettingsURLType {
    case terms, privacy, help
  }

  private func didTapEditProfile() {
    let vc = EditProfileViewController()
    vc.title = "Edit Profile"
    let navVC = UINavigationController(rootViewController: vc)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)

  }

  private func didTapInviteFriends() {

  }

  private func didTapSaveOriginalPosts() {

  }

  private func didTapOpenUrl(type: SettingsURLType) {
    let urlString: String
    switch type {
      case .terms:
        urlString = "help.instagram.com/581066165581870/?helpref=uf_share"

      case .privacy:
        urlString = "https://www.instagram.com/terms/accept/"

      case .help:
        urlString = "https://help.instagram.com"

    }

    guard let url = URL(string: urlString) else {
      return
    }

    let vc = SFSafariViewController(url: url)
    present(vc, animated: true)

  }

  private func didTapLogOut() {
    let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
      AuthManager.shared.logOut { success in
        DispatchQueue.main.async {
          if success {
            // present log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true) {
              self.navigationController?.popToRootViewController(animated: false)
              self.tabBarController?.selectedIndex = 0
            }
          } else {
            // error occurred
            fatalError("Could not log out user")
          }
        }
      }
    }))

    actionSheet.popoverPresentationController?.sourceView = tableView
    actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

    present(actionSheet, animated:  true)

  }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let model = data[indexPath.section][indexPath.row]
    model.handler()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = data[indexPath.section][indexPath.row].title
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}
