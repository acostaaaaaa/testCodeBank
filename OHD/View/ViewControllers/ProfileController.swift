//
//  ProfileController.swift
//  Magic
//

import UIKit

// MARK: - ProfileController class
class ProfileController: UIViewController {
    
    private let presenter = BasicPresenter(service: MainNetworking<BasicInfo>.basic)
    
    // MARK: - View attributes
    weak var scrollView: UIScrollView?
    weak var nameLabel: UILabel?
    weak var ageLabel: UILabel?
    weak var emailLabel: UILabel?
    weak var phoneLabel: UILabel?
    weak var websiteLabel: UILabel?
    weak var summaryLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString(LocalizedKeys.basicInfo.rawValue, comment: "Basic information")
        navigationItem.largeTitleDisplayMode = .never
        presenter.delegate = self
        presenter.start()
        customize()
    }
    
    private func customize() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        scrollView = scroll
        
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let landscapeView = UIImageView(image: #imageLiteral(resourceName: "landscape"))
        landscapeView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(landscapeView)
        
        landscapeView.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        landscapeView.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        landscapeView.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
        landscapeView.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        landscapeView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3).isActive = true
        
        let avatarView = UIImageView(image: #imageLiteral(resourceName: "hugo"))
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(avatarView)
        
        avatarView.centerXAnchor.constraint(equalTo: landscapeView.centerXAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: landscapeView.bottomAnchor, constant: -60).isActive = true
        
        let nameLabelTitle = UILabel.titleLabel()
        nameLabelTitle.text = NSLocalizedString(LocalizedKeys.name.rawValue, comment: "Name")
        scroll.addSubview(nameLabelTitle)
        
        let name = UILabel.bodyLabel()
        scroll.addSubview(name)
        nameLabel = name
        
        var views = ["name_lbl": nameLabelTitle, "name": name]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[name_lbl(60)]-(16)-[name]-(16)-|",
                                                         options: .alignAllCenterY, metrics: nil,
                                                         views: views)
        NSLayoutConstraint.activate(constraints)
        nameLabelTitle.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16.0).isActive = true
        
        let ageLabelTitle = UILabel.titleLabel()
        ageLabelTitle.text = NSLocalizedString(LocalizedKeys.age.rawValue, comment: "Age")
        scroll.addSubview(ageLabelTitle)
        
        let age = UILabel.bodyLabel()
        scroll.addSubview(age)
        ageLabel = age
        
        views = ["age_lbl": ageLabelTitle, "age": age]
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[age_lbl(60)]-(16)-[age]-(16)-|",
                                                     options: .alignAllCenterY, metrics: nil,
                                                     views: views)
        NSLayoutConstraint.activate(constraints)
        ageLabelTitle.topAnchor.constraint(equalTo: nameLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        
        let emailLabelTitle = UILabel.titleLabel()
        emailLabelTitle.text = NSLocalizedString(LocalizedKeys.email.rawValue, comment: "Email")
        scroll.addSubview(emailLabelTitle)
        
        let email = UILabel.bodyLabel()
        scroll.addSubview(email)
        emailLabel = email
        
        views = ["email_lbl": emailLabelTitle, "email": email]
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[email_lbl(60)]-(16)-[email]-(16)-|",
                                                     options: .alignAllCenterY, metrics: nil,
                                                     views: views)
        NSLayoutConstraint.activate(constraints)
        emailLabelTitle.topAnchor.constraint(equalTo: ageLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        
        let phoneLabelTitle = UILabel.titleLabel()
        phoneLabelTitle.text = NSLocalizedString(LocalizedKeys.phone.rawValue, comment: "Phone")
        scroll.addSubview(phoneLabelTitle)
        
        let phone = UILabel.bodyLabel()
        scroll.addSubview(phone)
        phoneLabel = phone
        
        views = ["phone_lbl": phoneLabelTitle, "phone": phone]
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[phone_lbl(60)]-(16)-[phone]-(16)-|",
                                                     options: .alignAllCenterY, metrics: nil,
                                                     views: views)
        NSLayoutConstraint.activate(constraints)
        phoneLabelTitle.topAnchor.constraint(equalTo: emailLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        
        let webLabelTitle = UILabel.titleLabel()
        webLabelTitle.text = NSLocalizedString(LocalizedKeys.website.rawValue, comment: "Website")
        scroll.addSubview(webLabelTitle)
        
        let website = UILabel.bodyLabel()
        scroll.addSubview(website)
        websiteLabel = website
        
        views = ["website_lbl": webLabelTitle, "website": website]
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[website_lbl(60)]-(16)-[website]-(16)-|",
                                                     options: .alignAllCenterY, metrics: nil,
                                                     views: views)
        NSLayoutConstraint.activate(constraints)
        webLabelTitle.topAnchor.constraint(equalTo: phoneLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        
        let summaryLabelTitle = UILabel.titleLabel()
        summaryLabelTitle.text = NSLocalizedString(LocalizedKeys.summary.rawValue, comment: "Summary")
        summaryLabelTitle.textAlignment = .left
        scroll.addSubview(summaryLabelTitle)
        
        summaryLabelTitle.topAnchor.constraint(equalTo: webLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        summaryLabelTitle.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16.0).isActive = true
        summaryLabelTitle.rightAnchor.constraint(equalTo: scroll.rightAnchor, constant: -16.0).isActive = true
        
        let summary = UILabel.bodyLabel()
        summary.numberOfLines = 0
        scroll.addSubview(summary)
        summaryLabel = summary
        
        summary.setContentHuggingPriority(.required, for: .vertical)
        summary.setContentCompressionResistancePriority(.required, for: .vertical)
        summary.topAnchor.constraint(equalTo: summaryLabelTitle.bottomAnchor, constant: 16.0).isActive = true
        summary.leftAnchor.constraint(equalTo: summaryLabelTitle.leftAnchor, constant: 16.0).isActive = true
        summary.rightAnchor.constraint(equalTo: summaryLabelTitle.rightAnchor, constant: 16.0).isActive = true
        summary.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 16.0).isActive = true
    }
}

// MARK: - Delegate
extension ProfileController: BasicPresenterDelegate {
    func basicPresenterDidFinishUpdatingInfo() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.nameLabel?.text = self.presenter.name
            self.ageLabel?.text = self.presenter.age
            self.emailLabel?.text = self.presenter.email
            self.phoneLabel?.text = self.presenter.phone
            self.summaryLabel?.text = self.presenter.summary
            self.websiteLabel?.text = self.presenter.website
        }
    }
    
    func basicPresenter(_ basicPresenter: BasicPresenter, didFinishWithError error: NetworkError) {
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
