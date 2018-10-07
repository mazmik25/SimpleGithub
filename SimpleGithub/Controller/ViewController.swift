//
//  ViewController.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/5/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var DEFAULT_PAGE_SIZE = 20
    let LIMIT = 100
    var users: [User]?
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.tableView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.users?.removeAll()
    }
    
    private func initView() {
        self.textField.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        self.users = [User]()
        
        self.getAllUsers()
    }

    private func getAllUsers() {
        self.showLoading(view: self.view)
        Api.getAllUser(page: DEFAULT_PAGE_SIZE) { (results, error) in
            if error != nil {
                self.hideLoading()
                self.connectionError()
            } else if results == nil {
                self.hideLoading()
                self.emptyData()
            } else {
                self.hideLoading()
                self.users = results!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK:- Table View Delegate And Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        if indexPath.row == self.users!.count - 1 && !isSearching {
            if self.DEFAULT_PAGE_SIZE != self.LIMIT {
                self.DEFAULT_PAGE_SIZE += 20
                self.getAllUsers()
            } else {
                self.initToast(color: UIColor.white, message: "You've reached the limit", duration: Duration.SHORT, position: .bottom)
            }
        }
        
        cell.user = self.users?[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.initToast(color: UIColor.white, message: "\(indexPath.row + 1). \(self.users?[indexPath.row].name ?? "Kosong")", duration: Duration.SHORT, position: .top)
    }
}

//MARK:- Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.elementsEqual("") {
            self.isSearching = true
            //filter data
            self.users = self.users!.filter({ (user) -> Bool in
                user.name.contains(textField.text!)
            })
        }
        
        self.tableView.reloadData()
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.isSearching = false
        self.users!.removeAll()
        self.getAllUsers()
        textField.endEditing(true)
        return true
    }
}
