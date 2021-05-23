//
//  ListVC.swift
//  AssignmentTest
//
//  Created by Anil on 02/04/21.
//

import UIKit

protocol ListVCLogic: class {
    func displayLogic(viewModel : ListModel.Process.ViewModel)
}

class ListVC: UIViewController, ListVCLogic{
    var offset = 0
    var limit = 5
    var list : [users]?
    var notExist = "Data Exist!"
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        list = []
        methodForSetUpTableview(tableViewObj : tableView)
        methodForInteractWithJson()
        
    }
    
    func methodForSetUpTableview(tableViewObj : UITableView){
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.register(UINib(nibName: "ListTableviewCell", bundle: nil), forCellReuseIdentifier: "ListTableviewCell")
        tableViewObj.rowHeight = UITableView.automaticDimension
        tableViewObj.estimatedRowHeight = 70
        view.addSubview(tableViewObj)
        tableViewObj.frame = view.bounds
    }
    
    var interactor: ListBusinessLogic?
    var router: ListRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        
        let viewController = self
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
    }
    
    func methodForInteractWithJson(){
        Spinner.start(from: self.view)
        let request = ListModel.Process.Request(type : "json")
        interactor?.List(request: request, offset: offset, limit: limit)
    }
    
    func displayLogic(viewModel: ListModel.Process.ViewModel) {
        DispatchQueue.main.async {
            Spinner.stop()
            if !viewModel.success{
                self.tableView.isHidden = true
                self.list = []
                self.tableView.reloadData()
            }else{
                self.tableView.isHidden = false
                self.notExist = viewModel.list?.message ?? ""
                let listObj = viewModel.list?.data?.users ?? []
                self.list! += listObj
                self.tableView.reloadData()
            }
        }
    }
    
}
extension ListVC : UITableViewDelegate, UITableViewDataSource{
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableviewCell") as? ListTableviewCell
        if list != nil{
            cell?.displayContent(item : list![indexPath.row])
        }

        if indexPath.row == list!.count-1{
            
            if notExist == "Data Exist!"{
                offset = limit
                limit = limit + 5
                self.methodForInteractWithJson()
            }
        }
        
        if cell != nil{
            return cell!
        }
        return UITableViewCell()
    }
    
}
