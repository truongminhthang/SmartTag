//
//  SmashTweetTableViewController.swift
//  SmartTag
//
//  Created by Trương Thắng on 4/9/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController {
    let container = AppDelegate.persistentContainer
    
    override func insertTweets(_ newTweets: [Twitter.Tweet]) {
        super.insertTweets(newTweets)
        updateDatabase(with: newTweets)
    }
    
    private func updateDatabase(with tweets:[Twitter.Tweet]) {
        container.performBackgroundTask { context in
            for tweetInfo in tweets {
                _ = try? Tweet.findOrCreateTweet(matching: tweetInfo, in: context )
            }
        }
        printDatabaseStatistics()
    }
    
    private func printDatabaseStatistics() {
        
        let tweetRequest : NSFetchRequest<Tweet> = Tweet.fetchRequest()
        if let tweetCount = (try? AppDelegate.context.fetch(tweetRequest))?.count {
            print("\(tweetCount) tweet(s)")
        }
        let twitterRequest : NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        if let twitterCount = (try? AppDelegate.context.fetch(twitterRequest))?.count {
            print("\(twitterCount) tweet(s)")
        }
    }
 
}
