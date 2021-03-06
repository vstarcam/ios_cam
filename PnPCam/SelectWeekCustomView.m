//
//  SelectWeekCustomView.m
//  P2PCamera
//
//  Created by yan luke on 13-6-27.
//
//

#import "SelectWeekCustomView.h"
#import "obj_common.h"
@interface SelectWeekCustomView()
@property (nonatomic, retain) NSMutableArray* weekArray;

@end

@implementation SelectWeekCustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [UIImage imageNamed:@"common_gray_btn"];
        self.userInteractionEnabled = YES;
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.frame = CGRectMake(0.f, 1.f, 80.f, 44.f);
        [self.backBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        self.backBtn.showsTouchWhenHighlighted = YES;
        self.backBtn.tag = 10;
        [self.backBtn addTarget:self action:@selector(SelectDay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];
        
        self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.forwardBtn.frame = CGRectMake(frame.size.width - 80.f, 1.f, 80.f, 44.f);
        [self.forwardBtn setImage:[UIImage imageNamed:@"forwordBtn"] forState:UIControlStateNormal];
        self.forwardBtn.showsTouchWhenHighlighted = YES;
        self.forwardBtn.tag = 11;
        [self.forwardBtn addTarget:self action:@selector(SelectDay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.forwardBtn];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width - self.backBtn.frame.size.width*2 - self.backBtn.frame.origin.x*2, frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = NSLocalizedStringFromTable(@"Sunday", @STR_LOCALIZED_FILE_NAME, nil);
        self.titleLabel.center = self.center;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.SelectIndex = 0;
        self.weekArray = [[NSMutableArray alloc] initWithObjects:NSLocalizedStringFromTable(@"Sunday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Monday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Tuesday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Wednesday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Thursday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Friday", @STR_LOCALIZED_FILE_NAME, nil), NSLocalizedStringFromTable(@"Saturday", @STR_LOCALIZED_FILE_NAME, nil), nil];
        
    }
    return self;
}
- (void) SelectDay:(UIButton*) btn{
    NSLog(@"_SelectIndex  %d  btn tag  %d",_SelectIndex,btn.tag);
    if (btn.tag == 11) {
        self.SelectIndex = self.SelectIndex + 1;
        if (self.SelectIndex > 6) {
            self.SelectIndex = 0;
        }
    }else if (btn.tag == 10){
        self.SelectIndex = self.SelectIndex - 1;
        if (self.SelectIndex < 0) {
            self.SelectIndex = 6;
        }
    }
    NSLog(@"_SelectIndex  %d  btn tag  %d",_SelectIndex,btn.tag);
    dispatch_async(dispatch_get_main_queue(),^{
        self.titleLabel.text = [_weekArray objectAtIndex:_SelectIndex];
    });
    if (_delegate != nil) {
        [_delegate SelectWeekCustomView:self ChangeSelectIndex:_SelectIndex];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) dealloc{
    [super dealloc];
    [_titleLabel release],_titleLabel = nil;
    [_weekArray release],_weekArray = nil;
    _backBtn = nil;
    _forwardBtn = nil;
}

@end
