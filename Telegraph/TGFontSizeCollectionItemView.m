#import "TGFontSizeCollectionItemView.h"
#import <LegacyComponents/TGPhotoEditorSliderView.h>
#import <LegacyComponents/TGFont.h>

#import "TGPresentation.h"

@interface TGFontSizeCollectionItemView ()
{
    TGPhotoEditorSliderView *_sliderView;
    UIImageView *_fontMinIconView;
    UIImageView *_fontMaxIconView;
}
@end

@implementation TGFontSizeCollectionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        static UIImage *knobViewImage = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^
        {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(40.0f, 40.0f), false, 0.0f);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetShadowWithColor(context, CGSizeMake(0, 1.5f), 3.5f, [UIColor colorWithWhite:0.0f alpha:0.25f].CGColor);
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextFillEllipseInRect(context, CGRectMake(6.0f, 6.0f, 28.0f, 28.0f));
            knobViewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        });
        
        _sliderView = [[TGPhotoEditorSliderView alloc] init];
        _sliderView.backgroundColor = [UIColor whiteColor];
        _sliderView.knobImage = knobViewImage;
        _sliderView.trackCornerRadius = 1.0f;
        _sliderView.trackColor = TGAccentColor();
        _sliderView.backColor = UIColorRGB(0xb7b7b7);
        _sliderView.lineSize = 2.0f;
        _sliderView.dotSize = 5.0f;
        _sliderView.minimumValue = 0.0f;
        _sliderView.maximumValue = 6.0f;
        _sliderView.startValue = 0.0f;
        _sliderView.value = 2.0f;
        _sliderView.positionsCount = 7;
        [_sliderView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_sliderView];
        
        _fontMinIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 8.0f, 9.0f)];
        [self addSubview:_fontMinIconView];
        
        _fontMaxIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 18.0f)];
        [self addSubview:_fontMaxIconView];
    }
    return self;
}

- (void)setPresentation:(TGPresentation *)presentation
{
    [super setPresentation:presentation];
    
    _fontMinIconView.image = presentation.images.fontSizeSmallIcon;
    _fontMaxIconView.image = presentation.images.fontSizeLargeIcon;
    _sliderView.trackColor = presentation.pallete.collectionMenuAccentColor;
    _sliderView.backgroundColor = presentation.pallete.collectionMenuCellBackgroundColor;
    _sliderView.backColor = presentation.pallete.collectionMenuAccessoryColor;
}

- (void)setValue:(int32_t)value
{
    _sliderView.value = value;
}

- (void)sliderValueChanged:(TGPhotoEditorSliderView *)sender
{
    if (self.valueChanged != nil)
        self.valueChanged((int32_t)sender.value);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _fontMinIconView.frame = CGRectMake(18.0f + self.safeAreaInset.left, floor((self.frame.size.height - _fontMinIconView.frame.size.height) / 2.0f), _fontMinIconView.frame.size.width, _fontMinIconView.frame.size.height);
    _fontMaxIconView.frame = CGRectMake(self.frame.size.width - _fontMaxIconView.frame.size.width - 14.0f - self.safeAreaInset.right, floor((self.frame.size.height - _fontMaxIconView.frame.size.height) / 2.0f), _fontMaxIconView.frame.size.width, _fontMaxIconView.frame.size.height);
    _sliderView.frame = CGRectMake(42.0f + self.safeAreaInset.left, 8.0f, self.frame.size.width - 84.0f - self.safeAreaInset.left - self.safeAreaInset.right, 44.0f);
}

@end
