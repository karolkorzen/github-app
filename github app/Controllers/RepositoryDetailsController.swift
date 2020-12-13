//
//  RepoDetailsController.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import UIKit
import SDWebImage

let cellIdentifier = "cellID"
let headerIdentifier = "headerID"

class RepositoryDetailsController: UITableViewController {
    
    //MARK: - Properties
    
    var viewModel: RepositoryDetailsViewModel
    let iv = UIImageView()
    
    //MARK: - Lifecycle
    
    init(withRepository repository: Repository){
        self.viewModel = RepositoryDetailsViewModel(withRepository: repository)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.fetchCommit {
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        tableView.register(CommitCell.self, forCellReuseIdentifier: cellIdentifier)
        view.backgroundColor = .white
        
        let footer = CommitsFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        footer.delegate = self
        tableView.tableFooterView = footer
        
        let header = CommitsHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 383), withRepository: viewModel.repository)
        tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        header.delegate = self
        tableView.tableHeaderView = header
    }
}

//MARK: - UITableViewDelegate / DataSource

extension RepositoryDetailsController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CommitCell
        cell.viewModel = RepositoryDetailsCellViewModel(withCommit: viewModel.commits[indexPath.row], withNumber: indexPath.row+1)
        cell.isUserInteractionEnabled = false
        return cell
    }
}

extension RepositoryDetailsController: CommitsHeaderViewDelegate {
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension RepositoryDetailsController: FooterDelegate {
    func shareRepo() {
        let url:URL = URL(string: viewModel.repository.html_url)!
        let activityViewController = UIActivityViewController(activityItems : [url], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
