//
//  ActiveChatViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 05/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ActiveChatViewController: JSQMessagesViewController {
    
    var user: User?
    
    var messages = [JSQMessage]()
    private var newMessageRefHandle: DatabaseHandle?
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setUpOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setUpIncomingBubble()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Chatting with: " + (user?.firstName)! + " " + (user?.lastName)!)
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(goBack(sender:)))
        navBar.setItems([navItem], animated: false)
        navItem.leftBarButtonItem = backButton
        
        /*--------------View Setup Done----------------*/
        
        
        // Fetching ID and displayname of sender
        self.senderId = Auth.auth().currentUser?.uid
        self.senderDisplayName = "John"
        
        // Removing default avatars provided by JSQMessagesViewController
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame.origin.y = navBar.frame.maxY
        
        observeMessages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func goBack(sender: UIButton) {
        let previousVC = CreateChatViewController()
        self.present(previousVC, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    private func setUpOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setUpIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let mesRef = Database.database().reference().child("Messages").childByAutoId()
        let messageItem = [
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "receiver": user?.key,
            "text": text!,
        ]
        mesRef.setValue(messageItem)
        //JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
    }
    
    private func observeMessages() {
        let mesRef = Database.database().reference().child("Messages")
        let messageQuery = mesRef.queryLimited(toLast:25)
        
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            // 3
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                // 4
                self.addMessage(withId: id, name: name, text: text)
                
                // 5
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }

}
