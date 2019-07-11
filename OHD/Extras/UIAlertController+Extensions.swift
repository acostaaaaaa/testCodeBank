
import UIKit

extension UIAlertController {
    func retryAction(with error: NetworkError, completion: @escaping(()-> Void)) -> UIAlertController{
        let customAlert = UIAlertController(title: NSLocalizedString(LocalizedKeys.error.rawValue, comment: "An Error"),
                                            message: error.description, preferredStyle: .alert)
        customAlert.addAction(UIAlertAction(title: LocalizedKeys.retry.rawValue, style: .default) { _ in
            completion()
        })
        return customAlert
    }
}
