//
//  ViewController.swift
//  ExPreventCapture
//
//  Created by 김종권 on 2022/10/06.
//

import UIKit

class ViewController: UIViewController {
  // MARK: Properties
  private var items: [String] {
    (0...30).map(String.init)
  }
  
  // MARK: UI
  private let label: UILabel = {
    let label = UILabel()
    label.text = "prevent capture 예제"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.makeSecure()
    
    [label, tableView]
      .forEach(view.addSubview(_:))
    
    NSLayoutConstraint.activate([
      label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
      label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
      label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
    ])
    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: label.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: label.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
      tableView.heightAnchor.constraint(equalToConstant: 300)
    ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    cell.backgroundColor = .systemGray.withAlphaComponent(0.3)
    return cell
  }
}
