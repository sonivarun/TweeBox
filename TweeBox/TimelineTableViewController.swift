//
//  TimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/6.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit
import AMScrollingNavbar
import Kingfisher
import Whisper

class TimelineTableViewController: UITableViewController
//    , ScrollingNavigationControllerDelegate
{
    
    fileprivate var timeline = [Array<Tweet>]() {
        didSet {
            print(">>> Batch >> \(timeline.count)")
            if let navigationController = navigationController {
                Whisper.hide(whisperFrom: navigationController)
            }
            tableView.separatorStyle = .singleLine
        }
    }
    
    public var maxID: String?
    public var sinceID: String?
    public var fetchNewer = true
    /*
     if there is a newer batch, there exists a maxID;
     if there is a older batch, there exists a sinceID.
     
     if last panning gesture is upward, fetchNewer is true;
     if last panning gesture is downward, fetchNewer is false.
     */
    
    // tap to segue
    weak var delegate:TweetWithPicTableViewCell?
    weak var profilrDelegate: TweetTableViewCell?
    
    fileprivate var clickedTweet: Tweet?
    fileprivate var clickedImageIndex: Int?
    fileprivate var clickMedia: UIImage?
    fileprivate var imageURLToShare: URL?
    fileprivate var media: [TweetMedia]!
    
//    private var warningTextLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  Warning text when table is empty
        
        if timeline.flatMap({ $0 }).count == 0 {
            
            let message = Message(title: "Pull down to refresh.", backgroundColor: .orange)
            tableView.separatorStyle = .none
            if let navigationController = navigationController {
                Whisper.show(whisper: message, to: navigationController, action: .present)
            }
        }

        
        // Hide bars on scrolling
//        if let navigationController = navigationController as? ScrollingNavigationController, let tabBarController = tabBarController {
//            navigationController.followScrollView(
//                tableView,
//                delay: 50.0,
//                scrollSpeedFactor: (Constants.naturalReading ? -1 : 1),
//                followers: [tabBarController.tabBar]
//            )
//        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        if let navigationController = navigationController as? ScrollingNavigationController {
//            navigationController.stopFollowingScrollView()
//        }
    }
    
        
    func insertNewTweets(with newTweets: [Tweet]) {
        self.timeline.insert(newTweets, at: 0)
        self.tableView.insertSections([0], with: .automatic)
    }
    
    
    func refreshTimeline() {
        
        let homeTimelineParams = HomeTimelineParams()
        
        let timeline = Timeline(
            maxID: maxID,
            sinceID: sinceID,
            fetchNewer: fetchNewer,
            resourceURL: homeTimelineParams.resourceURL,
            timelineParams: homeTimelineParams
        )
        
        timeline.fetchData { [weak self] (maxID, sinceID, tweets) in
            if let maxID = maxID {
                self?.maxID = maxID
            }
            if let sinceID = sinceID {
                self?.sinceID = sinceID
            }
            if let tweets = tweets {
                self?.insertNewTweets(with: tweets)
//                self?.tableView.reloadData()
            }
            
            Timer.scheduledTimer(
                withTimeInterval: TimeInterval(0.1),
                repeats: false) { (timer) in
                    self?.refreshControl?.endRefreshing()
            }
        }
        
        // FIX THIS: FOR REFRESH DOWNWORD
        let cells = self.tableView.visibleCells
        
        for cell in cells {
            if let tweetCell = cell as? TweetTableViewCell {
                tweetCell.section? += 1
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshTimeline()
    }
    
    @objc private func tapToPresentMediaViewer(byReactingTo tapGesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "To Media", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return timeline.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeline[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        let tweet = timeline[indexPath.section][indexPath.row]
        
        if let media = tweet.entities?.media {
            switch media.count {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
                if let tweetCell = cell as? TweetWithTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                }
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Pic and Text", for: indexPath)
                if let tweetCell = cell as? TweetWithPicAndTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.delegate = self
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                    tweetCell.mediaIndex = 0
                }
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Two Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetWithPicAndTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.delegate = self
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                }
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Three Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetWithPicAndTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.delegate = self
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                }
            case 4:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Four Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetWithPicAndTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.delegate = self
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                }
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
                if let tweetCell = cell as? TweetWithTextTableViewCell {
                    tweetCell.tweet = tweet
                    
                    // tap to segue
                    tweetCell.profilrDelegate = self
                    tweetCell.section = indexPath.section
                    tweetCell.row = indexPath.row
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
            if let tweetCell = cell as? TweetWithTextTableViewCell {
                tweetCell.tweet = tweet
                
                // tap to segue
                tweetCell.profilrDelegate = self
                tweetCell.section = indexPath.section
                tweetCell.row = indexPath.row
            }
        }
//        print(cell.bounds.size.height)
        return cell
    }
    
    
    override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
        return true
    }
}

// tap to segue
extension TimelineTableViewController: TweetWithPicTableViewCellProtocol, TweetTableViewCellProtocol {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageTapped" {
            if let imageViewer = segue.destination.content as? ImageViewerViewController {
                    imageViewer.image = clickMedia
                    imageViewer.imageURL = imageURLToShare
            }
        } else if segue.identifier == "videoTapped" {
            if let videoViewer = segue.destination.content as? VideoViewerViewController {
                videoViewer.tweetMedia = media[0]
            }
        } else if segue.identifier == "profileImageTapped" {
            if let profileVIewController = segue.destination.content as? UserTimelineTableViewController {
                profileVIewController.userID = (clickedTweet?.user.id)!
            }
        }
    }
    
    func profileImageTapped(section: Int, row: Int) {
        
        print("profile tapped")
        
        self.clickedTweet = timeline[section][row]
        
        performSegue(withIdentifier: "profileImageTapped", sender: nil)
    }

    
    func imageTapped(section: Int, row: Int, mediaIndex: Int, media: [TweetMedia]) {
        
        self.clickedTweet = timeline[section][row]
        self.clickedImageIndex = mediaIndex
        self.media = media
        self.imageURLToShare = clickedTweet?.entities?.mediaToShare?[clickedImageIndex ?? 0].mediaURL
        
        if media.count == 1, media[0].type != "photo" {
            performSegue(withIdentifier: "videoTapped", sender: nil)
        } else {
            if let clickedMediaURL = clickedTweet?.entities?.realMedia?[clickedImageIndex ?? 0].mediaURL {
                
                KingfisherManager.shared.retrieveImage(with: clickedMediaURL, options: nil, progressBlock: {
                    receivedSize, totalSize in
//                    let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                    print("Loading: \(percentage)%")
                    // TODO: progress indicator
                }) { [weak self] (image, error, cacheType, url) in
                    if let image = image {
                        self?.clickMedia = image
                        self?.performSegue(withIdentifier: "imageTapped", sender: nil)
                    }
                }
                
            }

        }
    }
}
