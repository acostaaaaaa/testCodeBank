//
//  MainPresenter.swift
//  Magic
//

import Foundation

// MARK: - MainPresenterDelegate protocol
protocol MainPresenterDelegate: class {
    func mainPresenterDidFinishUpdatingSections(_ mainPresenter: MainPresenter)
    func mainPresenter(_ mainPresenter: MainPresenter, didFinishWithError error: NetworkError)
    func mainPresenter(_ mainPresenter: MainPresenter, requestsNavigationToControllerWithIdentifier identifier: String)
}

// MARK: - MainPresenter class
class MainPresenter {
    private var service: NetworkingService
    private var sections: [DataSection] = [DataSection]()
    weak var delegate: MainPresenterDelegate?
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    func start(with session: URLSessionProtocol = URLSession.shared) {
        service.session = session
        service.fetchData() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let information):
                if let sections = information as? [DataSection] {
                    self.sections = sections
                    self.delegate?.mainPresenterDidFinishUpdatingSections(self)
                }
            case .failure(let error):
                self.delegate?.mainPresenter(self, didFinishWithError: error)
            }
        }
    }
    
    func section(forRow index: Int) -> DataSection {
        return sections[index]
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func didTapRow(at index: Int) {
        let identifier = sections[index].name
        delegate?.mainPresenter(self, requestsNavigationToControllerWithIdentifier: identifier)
    }
}
