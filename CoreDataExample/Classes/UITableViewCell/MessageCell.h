//  MessageCell.h

#import <UIKit/UIKit.h>

@class Message;

@interface MessageCell : UITableViewCell {
  Message              * _message;
  
  IBOutlet UILabel     * _messageLabel;
  IBOutlet UILabel     * _userNameLabel;
  IBOutlet UIImageView * _messageImageView;
}

@property (nonatomic, strong) Message * message;

- (id)initWithMessage:(Message *)aMessage;

@end