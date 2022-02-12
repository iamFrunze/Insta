//
//  EditProfileViewController.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import UIKit

struct EditProfileFormModel {
  let label: String
  let placeholder: String
  var value: String?
}

class EditProfileViewController: UIViewController, UITableViewDataSource {

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
    return tableView
  }()

  private var models = [[EditProfileFormModel]]()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    tableView.dataSource = self
    tableView.tableHeaderView = createTableHeaderView()
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Save",
      style: .done,
      target: self,
      action: #selector(didTapSave)
    )

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Cancel",
      style: .plain,
      target: self,
      action: #selector(didTapCancel)
    )
  }

  private func configureModels() {
    // nmae, username, website, bio
    let section1Labels = ["Name", "Username", "Bio"]
    var section1 = [EditProfileFormModel]()
    for label in section1Labels {
      let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
      section1.append(model)
    }
    models.append(section1)

    //email, phone, gender
    let section2Labels = ["Email", "Phone", "Gender"]
    var section2 = [EditProfileFormModel]()
    for label in section2Labels {
      let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
      section2.append(model)
    }
    models.append(section2)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  // MARK: - Tableview

  private func createTableHeaderView() -> UIView {
    let header = UIView(frame: CGRect(x: 0,
                                      y: 0,
                                      width: view.width,
                                      height: view.height / 4).integral)

    let size = header.height / 1.5
    let profilePictureButton = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                      y: (header.height - size) / 2,
                                                      width: size,
                                                      height: size))
    header.addSubview(profilePictureButton)
    profilePictureButton.layer.masksToBounds = true
    profilePictureButton.layer.cornerRadius = size / 2.0
    profilePictureButton.tintColor = .label
    profilePictureButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)

    profilePictureButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
    profilePictureButton.layer.borderWidth = 1
    profilePictureButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    return header
  }

  @objc private func didTapProfilePhotoButton() {

  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return models.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models[section].count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard section == 1 else {
      return nil
    }
    return "Private information"
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
    cell.configure(with: model)
    cell.delegate = self
    return cell
  }

  // MARK: - Action

  @objc private func didTapSave() {
    // Save info to databse
    dismiss(animated: true, completion: nil)
  }

  @objc private func didTapCancel() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func didTapChangeProfilePicture() {
    let actionSheet = UIAlertController(
      title: "Profile Picture",
      message: "Change profile picture",
      preferredStyle: .actionSheet
    )

    actionSheet.addAction(UIAlertAction(
      title: "Take Photo", style: .default) { _ in })

    actionSheet.addAction(UIAlertAction(
      title: "Choose from Library", style: .default) { _ in })

    actionSheet.addAction(UIAlertAction(
      title: "Cancel", style: .cancel, handler: nil))

    actionSheet.popoverPresentationController?.sourceView = view
    actionSheet.popoverPresentationController?.sourceRect = view.bounds

    present(actionSheet, animated: true)
  }

}

extension EditProfileViewController: FormTableViewCellDelegate {
  func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
    // Update the model


  }
}
