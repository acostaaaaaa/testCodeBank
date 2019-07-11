//
//  ViewController.swift
//  Magic
//

import UIKit

// MARK: - MainViewController class
class MainViewController: UITableViewController {
    
    // MARK: - Properties
    private let presenter = MainPresenter(service: MainNetworking<[DataSection]>.main)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString(LocalizedKeys.title.rawValue, comment: "CV")
        presenter.delegate = self
        presenter.start()
    }
}


// MARK: - Data Source
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.main) as? MainCell else {
            fatalError("Cell of type \(Identifier.Cell.main) could not be dequeued.")
        }
        
        let section = presenter.section(forRow: indexPath.row)
        cell.sectionNameLabel?.text = section.name
        cell.sectionIconImageView?.image = UIImage(named: section.icon) ?? UIImage(named: "default")
        
        return cell
    }
}

// MARK: - Delegate
extension MainViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Presenter delegate
extension MainViewController: MainPresenterDelegate {
    func mainPresenterDidFinishUpdatingSections(_ mainPresenter: MainPresenter) {
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func mainPresenter(_ mainPresenter: MainPresenter, didFinishWithError error: NetworkError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alertController =  UIAlertController().retryAction(
                with: error, completion: { [weak self] in
                    self?.presenter.start()
            })
            self.present(alertController, animated: true)
        }
    }
    
    func mainPresenter(_ mainPresenter: MainPresenter, requestsNavigationToControllerWithIdentifier identifier: String) {
        guard let controller = navigationController?.storyboard?.instantiateViewController(withIdentifier: identifier) else {
            fatalError("Identifier for controller does not exist")
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
