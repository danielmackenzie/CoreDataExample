//  MessageCell.m

#import "MessageCell.h"
#import "User.h"
#import "Message.h"
#import "NSDataAdditions.h"

@implementation MessageCell

@synthesize message = _message;

#pragma mark - Getters

- (Message *)message; {
  return _message;
}

#pragma mark - Setters

- (void)setMessage:(Message *)aMessage; {
  _messageLabel.text = aMessage.messageText;
  _userNameLabel.text = [NSString stringWithFormat:@"%@ %@", aMessage.user.first_name, aMessage.user.last_name];
  _messageImageView.image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:aMessage.imageData]];
}

#pragma mark - Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier; {
  if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])){
    
  }
  return self;
}

- (id)initWithMessage:(Message *)aMessage; {
  if((self = [super init])){
    _message = aMessage;
  }
  return self;
}

@end