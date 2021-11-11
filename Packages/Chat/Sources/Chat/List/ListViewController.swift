import UIKit

class ListViewController: UIViewController {

  private var tableView: UITableView!

  override func loadView() {
    tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self

    view = tableView
  }
}

extension ListViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.accessoryType = .disclosureIndicator
    cell.textLabel?.text = "Cell \(indexPath.row)"
    return cell
  }

}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    present(Chat.conversation(), animated: true, completion: nil)
  }
}
