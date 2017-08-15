//
//  UserListTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    var userList = [Array<TwitterUser>]()
    
    public var nextCursor = "-1"
    public var previousCursor = "-1"
    public var fetchOlder = true
    
    public var userListParams: UserListParams?
    public var resourceURL: (String, String)?
    
    private var selectedUser: TwitterUser?

        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshUserList()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.refreshControl?.endRefreshing()
    }

    
    private func insertNewUsers(with newUsers: [TwitterUser]) {
        self.userList.insert(newUsers, at: 0)
        self.tableView.insertSections([0], with: .automatic)
    }

    
    func refreshUserList() {
     
        let userListFetcher = UserList(
            resourceURL: resourceURL!,
            userListParams: userListParams!,
            fetchOlder: fetchOlder,
            nextCursor: nextCursor,
            previousCursor: previousCursor
        )
        
        userListFetcher.fetchData { [weak self] (nextCursor, previousCursor, newUserList) in
            
            self?.nextCursor = nextCursor
            self?.previousCursor = previousCursor
            
            if newUserList.count > 0 {
                self?.insertNewUsers(with: newUserList)
            }
            
            Timer.scheduledTimer(
                withTimeInterval: TimeInterval(0.1),
                repeats: false) { (timer) in
                    self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshUserList()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return userList.count
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = userList[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Twitter User", for: indexPath)
        
        if let userCell = cell as? TwitterUserTableViewCell {
            userCell.user = user
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedUser = userList[indexPath.section][indexPath.row]
        
        performSegue(withIdentifier: "View User", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "View User" {
            if let userTimelineTableViewController = segue.destination as? UserTimelineTableViewController {
                userTimelineTableViewController.user = selectedUser
            }
        }
    }
}


//enum UserListType {
//    case follower
//    case following
//}
