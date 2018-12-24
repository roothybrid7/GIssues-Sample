//
//  IssueTableViewController.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class IssueTableViewController: UITableViewController, ContextInstanceAware {
    private let disposeBag = DisposeBag()

    var viewModel: IssuesViewModel!

    func configureForInit() {
        viewModel = resolve(keyPath: \.viewModelProvider).makeIssues()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureForInit()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureForInit()
    }

    override init(style: UITableView.Style) {
        super.init(style: style)
        configureForInit()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        bindViewModel()
    }

    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(type(of: self).viewWillAppear(_:))).mapTo(()).asDriver(onErrorDriveWith: .empty())
        let pullToRefresh = tableView.refreshControl!.rx.controlEvent(.valueChanged).asDriver()
        let fetcher = Driver.merge(viewWillAppear, pullToRefresh)
        let selector = tableView.rx.itemSelected.mapAt(\.row).asDriver(onErrorDriveWith: .empty())
        let handler = IssueHandler(fetcher: fetcher, selector: selector)
        let presenter = viewModel.build(controller: handler)

        presenter.loading.drive(tableView.refreshControl!.rx.isRefreshing).disposed(by: disposeBag)
//        presenter.issues.drive(tableView.rx.items(cellIdentifier: <#T##String#>, cellType: <#T##Cell.Type#>))
        presenter.selectedIssueNumber.drive(rx.navigateDetail).disposed(by: disposeBag)
    }
}

extension Reactive where Base: IssueTableViewController {

    var navigateDetail: Binder<Int> {
        return Binder(base) { viewController, issueNumber in
        }
    }
}
