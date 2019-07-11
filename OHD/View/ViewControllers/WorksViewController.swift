//
//  WorksViewController.swift
//  Magic
//

import UIKit

// MARK: - WorksViewController class
class WorksViewController: UICollectionViewController {
    
    private let presenter = WorkPresenter(service: MainNetworking<[WorkData]>.work)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString(LocalizedKeys.workExperience.rawValue, comment: "Work experience")
        navigationItem.largeTitleDisplayMode = .never
        presenter.delegate = self
        presenter.start()
    }
}

// MARK: - Data Source
extension WorksViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfWorks()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.work, for: indexPath) as? WorkCell else {
            fatalError("Cell of type \(Identifier.Cell.work) could not be dequeued.")
        }
        
        configure(cell, at: indexPath)
        
        return cell
    }
    
    func configure(_ cell: WorkCell, at indexPath: IndexPath) {
        let work = presenter.work(forItemAt: indexPath.item)
        cell.companyLabel?.text = work.company
        cell.positionLabel?.text = work.position
        cell.dateLabel?.text = "\(work.startDate) - \(work.endDate ?? "actual")"
        cell.summaryLabel?.text = work.summary
    }
}

// MARK: - Flow Layout methods.
extension WorksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = 20
        let availableWidth = view.frame.width - paddingSpace - 2 * view.safeAreaInsets.left

        let itemSize = CGSize(width: availableWidth, height: 250)
        
        return itemSize
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - Presenter delegate
extension WorksViewController: WorkPresenterDelegate {
    func workPresenterDidFinishUpdatingSections() {
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func workPresenter(_ workPresenter: WorkPresenter, didFinishWithError error: NetworkError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alertController = UIAlertController().retryAction(
                with: error, completion: { [weak self] in
                    self?.presenter.start()
            })
            self.present(alertController, animated: true)
        }
    }
}

