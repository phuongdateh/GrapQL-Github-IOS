//
//  IssuesPresenter.swift
//  ApolloGraphQL
//
//  Created by DoanDuyPhuong on 8/6/20.
//  Copyright © 2020 prox.com. All rights reserved.
//

import Foundation
import RealmSwift

class IssuesPresenter: IssuesPresenterProtocol {
    weak var view: IssuesViewProtocol?
    var wireFrame: IssuesWireFrameProtocol?
    var interactor: IssuesInteractorInputProtocol?
    
    var issueList: Results<IssueNodeModel>!
    
    func viewDidLoad() {
        if let view = view {
            view.beginLoading()
        }
        if let interactor = interactor {
            interactor.initIssues()
            interactor.getIssues()
        }
    }
    
    func pushIssueDetail(issueId: String) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushIssueDetail(issueId, from: view)
        }
    }
    
    func reloadData() {
        interactor?.getIssues()
    }
    
    func handleChangeStateIssue(index: Int) {
        var tmpList: IssueList!
        if let interactor = interactor {
            interactor.initIssues()
        }
        if let issueList = issueList, issueList.isInvalidated == false, issueList.count > 0 {
            if index == 0 {
                tmpList = issueList.filter("state = %@", IssueState.open.rawValue)
                self.issueList = tmpList
            }
            else if index == 1 {
                tmpList = issueList.filter("state = %@", IssueState.closed.rawValue)
                self.issueList = tmpList
            }
        }
        if let view = view {
            view.updateView()
        }
    }
}
extension IssuesPresenter: IssuesInteractorOutputProtocol {
    func didInitIssues(_ issues: Results<IssueNodeModel>) {
        self.issueList = issues
        if let interactor = interactor, let issues = self.issueList {
            interactor.registerChange(of: issues)
        }
    }
    
    func getIssuesSuccess() {
        if let view = view {
            view.endLoading()
        }
    }
    
    func getIssuesFail() {
        if let view = view {
            view.endLoading()
        }
    }
    
    func receiveChange(of change: RealmCollectionChange<IssueList>) {
        if let view = view {
            view.updateView()
        }
    }
}
