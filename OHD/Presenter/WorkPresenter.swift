//
//  WorkPresenter.swift
//  Magic
//

import Foundation

// MARK: - WorkPresenterDelegate protocol
protocol WorkPresenterDelegate: class {
    func workPresenterDidFinishUpdatingSections()
    func workPresenter(_ workPresenter: WorkPresenter, didFinishWithError error: NetworkError)
}

// MARK: - WorkPresenter class
class WorkPresenter {
    private let service: NetworkingService
    private var works: [WorkData] = [WorkData]()
    weak var delegate: WorkPresenterDelegate?
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    func start() {
        service.fetchData() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let information):
                if let works = information as? [WorkData] {
                    self.works = works
                    self.delegate?.workPresenterDidFinishUpdatingSections()
                }
            case .failure(let error):
                self.delegate?.workPresenter(self, didFinishWithError: error)
            }
        }
    }
    
    func work(forItemAt index: Int) -> WorkData {
        return works[index]
    }
    
    func numberOfWorks() -> Int {
        return works.count
    }
}
