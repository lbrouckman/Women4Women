//
//  ConversationViewController.swift
//  Women4Women
//
//  Created by chris lucas on 5/11/17.
//  Copyright © 2017 cs194w. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

final class ConversationViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var conversationRef: FIRDatabaseReference?
    var conversation: Conversation? {
        didSet {
            title = conversation?.name
        }
    }
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    private lazy var messageRef: FIRDatabaseReference = self.conversationRef!.child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
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
    
    //    1. Here you retrieve the message.
    //    2. If the message was sent by the local user, return the outgoing image view.
    //    3. Otherwise, return the incoming image view.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        // need for avatars.
        //collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        //collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        observeMessages()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    1. Using childByAutoId(), you create a child reference with a unique key.
    //    2. Then you create a dictionary to represent the message.
    //    3. Next, you Save the value at the new child location.
    //    4. You then play the canonical “message sent” sound.
    //    5. Finally, complete the “send” action and reset the input toolbar to empty.
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            ]
        itemRef.setValue(messageItem) // 3
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        finishSendingMessage() // 5
    }
    
    
    //    1. Start by creating a query that limits the synchronization to the last 25 messages.
    //    2. Use the .ChildAdded event to observe for every child item that has been added, and will be added,  at the messages location.
    //    3. Extract the messageData from the snapshot.
    //    4. Call addMessage(withId:name:text) to add the new message to the data source.
    //    5. Inform JSQMessagesViewController that a message has been received.
    private func observeMessages() {
        messageRef = conversationRef!.child("messages")
        let messageQuery = messageRef.queryLimited(toLast:25) // 1.
        
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in // 3
            let messageData = snapshot.value as! Dictionary<String, String>
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                self.addMessage(withId: id, name: name, text: text) // 4.
                self.finishReceivingMessage() // 5.
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
