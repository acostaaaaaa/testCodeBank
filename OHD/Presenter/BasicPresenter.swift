//
//  BasicPresenter.swift
//  Magic
//

import Foundation

// MARK: - BasicPresenterDelegate protocol
protocol BasicPresenterDelegate: class {
    func basicPresenterDidFinishUpdatingInfo()
    func basicPresenter(_ basicPresenter: BasicPresenter, didFinishWithError error: NetworkError)
}

// MARK: - BasicPresenter class
class BasicPresenter {
    private let service: NetworkingService
    private var basicInfo: BasicInfo = BasicInfo.empty()
    weak var delegate: BasicPresenterDelegate?
    
    var name: String {
        return basicInfo.name
    }
    
    var age: String {
        return "\(basicInfo.age) \(NSLocalizedString(LocalizedKeys.years.rawValue, comment: "Calendar years"))"
    }
    
    var email: String {
        return basicInfo.email
    }
    
    var phone: String {
        return basicInfo.phone
    }
    
    var website: String {
        return basicInfo.website
    }
    
    var summary: String {
        return basicInfo.summary
    }
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    func start() {
        service.fetchData() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let information):
                if let basicInfo = information as? BasicInfo {
                    self.basicInfo = basicInfo
                    self.delegate?.basicPresenterDidFinishUpdatingInfo()
                }
            case .failure(let error):
                self.delegate?.basicPresenter(self, didFinishWithError: error)
            }
        }
    }
}
