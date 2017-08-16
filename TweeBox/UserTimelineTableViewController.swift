//
//  UserTimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/10.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit
import Kingfisher
import MXParallaxHeader
import VisualEffectView

class UserTimelineTableViewController: TimelineTableViewController {
    
    public var user: TwitterUser? {
        didSet {
            userID = user?.id
        }
    }

    var userID: String? {
        didSet {
            refreshTimeline()
        }
    }
    
    private var profileImage: UIImage?
    private var profileImageURL: URL?
    
    private var profileBannerImage: UIImage?
    private var profileBannerImageURL: URL?
    
    
    private let headerView = UIImageView()
    private var visualEffectView: VisualEffectView?
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let screenNameLabel = UILabel()
    private let bioLabel = UILabel()
    private var locationLabel: UILabel?
    private var userURLButton: UIButton?
    private let folllowerButton = UIButton()
    private let folllowingButton = UIButton()
    
    private var objects = [UIView?]()
    
    private var headerHeight: CGFloat = 0
    private var headerHeightCalculated = false
    
//    private var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let height = tableView.parallaxHeader.view?.bounds.height {

//            pullToRefresh(height)
            makeProfileObjectsDisapearByPulling(height)
        }
        
        if !headerHeightCalculated {
            calculateHeaderHeight()
        }
        
//        print(">>> headerHeight >> \(headerHeight)")
    }
    
//    private func pullToRefresh(_ height: CGFloat) {
//        if height > CGFloat(400), !isRefreshing {
//            print("refreshing")
//            isRefreshing = true
//            refreshTimeline()
//        }
//    }
    
    private func makeProfileObjectsDisapearByPulling(_ height: CGFloat) {
        
        objects = [profileImageView, nameLabel, screenNameLabel, bioLabel, locationLabel, userURLButton]
        
        visualEffectView?.blurRadius = min(10 * max(0, (headerHeight + Constants.profilePanelDragOffset - height) / Constants.profilePanelDragOffset), 10)
        visualEffectView?.colorTintAlpha = min(0.5 * max(0, (headerHeight + Constants.profilePanelDragOffset - height) / Constants.profilePanelDragOffset), 0.5)
        
        for object in objects {
            if let object = object {
                object.alpha = min(max(0, (headerHeight + Constants.profilePanelDragOffset - height) / Constants.profilePanelDragOffset), 1)
            }
        }
    }
    
    private func calculateHeaderHeight() {
        
        if let userURLButton = userURLButton {
            let convertedBounds = headerView.convert(userURLButton.bounds, from: userURLButton)
            headerHeight = convertedBounds.maxY
        } else if let locationLabel = locationLabel {
            let convertedBounds = headerView.convert(locationLabel.bounds, from: locationLabel)
            headerHeight = convertedBounds.maxY
        } else {
            let bioConvertedBounds = headerView.convert(bioLabel.bounds, from: bioLabel)
            let imageConvertedBounds = headerView.convert(profileImageView.bounds, from: profileImageView)
            headerHeight = max(bioConvertedBounds.maxY, imageConvertedBounds.maxY)
        }
        
        if headerHeight > (Constants.profileToolbarHeight + Constants.contentUnifiedOffset) {
            
            headerHeight = max(headerHeight, CGFloat(2 * Constants.profileImageRadius + Constants.contentUnifiedOffset))
            headerHeight += (Constants.profileToolbarHeight + Constants.contentUnifiedOffset)
            tableView.parallaxHeader.height = headerHeight
            headerHeightCalculated = true
        }
    }
    
//    override func hideBarsOnScrolling() { }
//    override func stopHiddingbard() { }
        
    override func refreshTimeline() {
        
        let userTimelineParams = UserTimelineParams(of: userID!)
        
        let timeline = Timeline(
            maxID: maxID,
            sinceID: sinceID,
            fetchNewer: fetchNewer,
            resourceURL: userTimelineParams.resourceURL,
            timelineParams: userTimelineParams
        )
        
        timeline.fetchData { [weak self] (maxID, sinceID, tweets) in
            if maxID != nil {
                self?.maxID = maxID!
            }
            if sinceID != nil {
                self?.sinceID = sinceID!
            }
            if tweets.count != 0 {
                self?.insertNewTweets(with: tweets)
//                self?.tableView.reloadData()
            }
            
//            Timer.scheduledTimer(
//                withTimeInterval: TimeInterval(0.1),
//                repeats: false) { (timer) in
//                    self?.refreshControl?.endRefreshing()
//            }
        }
//        isRefreshing = false
    }
    
    override func profileImageTapped(section: Int, row: Int) {
        
        print("profile tapped")
        
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileViewController")
        
        let segue = UIStoryboardSegue(identifier: "profileImageTapped", source: self, destination: destinationViewController) {
            self.navigationController?.show(destinationViewController, sender: self)
        }
        
        self.clickedTweet = timeline[section][row]
        
        self.prepare(for: segue, sender: self)
        segue.perform()
    }
    
    override func showEmptyWarningMessage() {
        emptyWarningCollapsed = true
    }
    
    @objc private func tapToViewBannerImage(_ sender: UIGestureRecognizer) {
        print(">>> banner tapped")
        clickMedia = profileBannerImage
        imageURLToShare = profileBannerImageURL
        performSegue(withIdentifier: "imageTapped", sender: self)
    }
    
    @objc private func tapToViewProfileImage(_ sender: UIGestureRecognizer) {
        print(">>> head tapped")
        clickMedia = profileImage
        imageURLToShare = profileImageURL
        performSegue(withIdentifier: "imageTapped", sender: self)
    }

    
    // Header
    private func addHeader() {
        
        headerView.isUserInteractionEnabled = true
        headerView.kf.setImage(with: user?.profileBannerURL, placeholder: nil, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
            self?.profileBannerImage = image
            self?.profileBannerImageURL = url
        }
        
        let tapOnBanner = UITapGestureRecognizer(target: self, action: #selector(tapToViewBannerImage(_:)))
        tapOnBanner.numberOfTapsRequired = 1
        tapOnBanner.numberOfTouchesRequired = 1
        headerView.addGestureRecognizer(tapOnBanner)
        
        visualEffectView = VisualEffectView(frame: view.bounds)
        visualEffectView?.blurRadius = 10
        visualEffectView?.colorTint = .black
        visualEffectView?.colorTintAlpha = 0.5
        headerView.addSubview(visualEffectView!)
        
        
        headerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView).offset(-25)
            make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset)
            make.width.equalTo(Constants.profileImageRadius * 2)
            make.height.equalTo(Constants.profileImageRadius * 2)
        }
        profileImageView.kf.setImage(with: user?.profileImageURL, placeholder: nil, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
            self?.profileImage = image
            self?.profileImageURL = url
        }
        
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = Constants.profileImageRadius
        profileImageView.clipsToBounds = true
        
        profileImageView.isOpaque = false
        
        let tapOnHead = UITapGestureRecognizer(target: self, action: #selector(tapToViewProfileImage(_:)))
        tapOnHead.numberOfTapsRequired = 1
        tapOnHead.numberOfTouchesRequired = 1
        headerView.addGestureRecognizer(tapOnHead)
        
        
        headerView.addSubview(nameLabel)
        nameLabel.text = user?.name
        nameLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 22)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset + (Constants.profileImageRadius * 2) + 10)
            make.top.equalTo(headerView).offset(Constants.contentUnifiedOffset)
        }
        nameLabel.isOpaque = false
        
    
        headerView.addSubview(screenNameLabel)
        screenNameLabel.text = "@\(user?.screenName ?? "twitterUser")"
        screenNameLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption1), size: 15)
        screenNameLabel.textColor = .lightGray
        screenNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset + (Constants.profileImageRadius * 2) + 9)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
        }
        screenNameLabel.isOpaque = false
        
        
        headerView.addSubview(bioLabel)
        bioLabel.lineBreakMode = .byWordWrapping
        bioLabel.numberOfLines = 0
        
        bioLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 12)

        bioLabel.textColor = .white
        bioLabel.text = user?.description
        bioLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset + (Constants.profileImageRadius * 2) + 10)
            make.right.equalTo(headerView).offset(-Constants.contentUnifiedOffset)
            make.top.equalTo(screenNameLabel.snp.bottom).offset(8)
        }
        bioLabel.isOpaque = false
        
        
        if let location = user?.location, location != "" {
            locationLabel = UILabel()
            headerView.addSubview(locationLabel!)
            locationLabel?.text = location
            locationLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption2), size: 12)
            locationLabel?.textColor = .lightGray
            locationLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset + (Constants.profileImageRadius * 2) + 9)
                make.top.equalTo(bioLabel.snp.bottom).offset(6)
            }
            locationLabel?.isOpaque = false
        }
        
        if let userURL = user?.url {
            userURLButton = UIButton()
            headerView.addSubview(userURLButton!)
            userURLButton?.snp.makeConstraints { (make) in
                make.left.equalTo(headerView).offset(Constants.contentUnifiedOffset + (Constants.profileImageRadius * 2) + 9)
                if let location = user?.location, location != "" {
                    make.top.equalTo(locationLabel!.snp.bottom).offset(5)
                } else {
                    make.top.equalTo(bioLabel.snp.bottom).offset(5)
                }
            }
            userURLButton?.setTitle(userURL.absoluteString, for: .normal)
            userURLButton?.setTitleColor(.lightGray, for: .normal)
            //            userURLButton.titleLabel?.textAlignment = .center
            userURLButton?.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption2), size: 12)
            //            userURLButton(forAction: #selector(tapFollowerButton(_:)), withSender: self)
            
        }

        
        let toolbar = UIToolbar()
        headerView.addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.bottom.equalTo(headerView)
            make.height.equalTo(50)
            make.width.equalTo(headerView)
        }
        toolbar.barStyle = .default
        
        
        toolbar.addSubview(folllowerButton)
        folllowerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(toolbar)
            make.leading.equalTo(toolbar)
            make.width.equalTo(toolbar).multipliedBy(0.5)
            make.height.equalTo(toolbar)
        }
        folllowerButton.setTitle("\(user?.followersCount ?? 0) follower", for: .normal)
        folllowerButton.setTitleColor(.darkGray, for: .normal)
        folllowerButton.titleLabel?.textAlignment = .center
        folllowerButton.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption2), size: 14)
        folllowerButton.addTarget(self, action: #selector(viewFollowerList(_:)), for: .touchUpInside)
        
        
        toolbar.addSubview(folllowingButton)
        folllowingButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(toolbar)
            make.trailing.equalTo(toolbar)
            make.width.equalTo(toolbar).multipliedBy(0.5)
            make.height.equalTo(toolbar)
        }
        folllowingButton.setTitle("\(user?.followingCount ?? 0) following", for: .normal)
        folllowingButton.setTitleColor(.darkGray, for: .normal)
        folllowingButton.titleLabel?.textAlignment = .center
        folllowingButton.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption2), size: 14)
        folllowingButton.addTarget(self, action: #selector(viewFollowingList(_:)), for: .touchUpInside)
        
        let separator = UIButton()
        toolbar.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.center.equalTo(toolbar)
            make.width.equalTo(1)
            make.height.equalTo(toolbar).multipliedBy(0.6)
        }
        separator.backgroundColor = .gray
        separator.isUserInteractionEnabled = false
        
        
        headerView.contentMode = .scaleAspectFill
        
        tableView.parallaxHeader.view = headerView
        tableView.parallaxHeader.mode = .fill
        tableView.parallaxHeader.minimumHeight = Constants.profileToolbarHeight
    }
    
    @IBAction private func viewFollowerList(_ sender: Any?) {
        performSegue(withIdentifier: "User List", sender: folllowerButton)
    }
    
    @IBAction private func viewFollowingList(_ sender: Any?) {
        performSegue(withIdentifier: "User List", sender: folllowingButton)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "User List" {
            if let sender = sender as? UIButton, let userListTableViewController = segue.destination.content as? UserListTableViewController {
                if (sender.titleLabel?.text?.hasSuffix("follower") ?? false) {
                    userListTableViewController.resourceURL = ResourceURL.followers_list
                } else if (sender.titleLabel?.text?.hasSuffix("following") ?? false) {
                    userListTableViewController.resourceURL = ResourceURL.followings_list
                }
                userListTableViewController.userListParams = UserListParams(userID: userID!)
            }
        }

    }
}
