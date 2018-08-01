#import <UIKit/UIKit.h>
#import <SSignalKit/SSignalKit.h>

@class TGLocationMediaAttachment;
@class TGLocationPallete;

@interface TGLocationInfoCell : UITableViewCell

@property (nonatomic, strong) TGLocationPallete *pallete;

@property (nonatomic, copy) void (^locatePressed)(void);
@property (nonatomic, copy) void (^directionsPressed)(void);

@property (nonatomic, readonly) UIButton *directionsButton;

- (void)setLocation:(TGLocationMediaAttachment *)location messageId:(int32_t)messageId userLocationSignal:(SSignal *)userLocationSignal;

@end

extern NSString *const TGLocationInfoCellKind;
extern const CGFloat TGLocationInfoCellHeight;

