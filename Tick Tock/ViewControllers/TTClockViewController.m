#import "TTClockViewController.h"

#import <BEMAnalogClockView.h>

static const CGFloat hiddenAlpha = 0.0f;
static const CGFloat visibileAlpha = 1.0f;

@interface TTClockViewController () <BEMAnalogClockDelegate>

@property (weak, nonatomic) IBOutlet BEMAnalogClockView *analogClock;
@property (weak, nonatomic) IBOutlet UIView *digitalTimeContainer;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UIView *clockDotView;

@end

@implementation TTClockViewController

#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAnalogClock];
    [self setUpView];
    [self setUpObservers];
    [self hideControls];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showControlsAnimated:YES];
    [self.analogClock reloadClock];
}


#pragma mark - Internal Methods 

- (void)setUpAnalogClock {
    self.analogClock.enableShadows = NO;
    self.analogClock.realTime = YES;
    self.analogClock.currentTime = YES;
    self.analogClock.setTimeViaTouch = NO;
    self.analogClock.delegate = self;

    self.analogClock.borderColor = UIColor.clearColor;
    self.analogClock.borderWidth = 0.0f;

    self.analogClock.faceBackgroundColor = UIColor.TTGreyColor;

    self.analogClock.hourHandColor = UIColor.TTPinkColor;
    self.analogClock.hourHandLength = 75.0f;
    self.analogClock.hourHandWidth = 2.0f;
    self.analogClock.hourHandOffsideLength = 0.0f;

    self.analogClock.minuteHandColor = UIColor.TTPinkColor;
    self.analogClock.minuteHandLength = 100.0f;
    self.analogClock.minuteHandWidth = 2.0f;
    self.analogClock.minuteHandOffsideLength = 0.0f;

    self.analogClock.secondHandColor = UIColor.TTPinkColor;
    self.analogClock.secondHandLength = 120.0f;
    self.analogClock.secondHandWidth = 0.5f;
}

- (void)setUpView {
    self.view.backgroundColor = UIColor.TTDarkGreyColor;
    self.hoursLabel.backgroundColor = UIColor.TTGreyColor;
    self.minutesLabel.backgroundColor = UIColor.TTGreyColor;

    self.minutesLabel.textColor = UIColor.TTPinkColor;
    self.hoursLabel.textColor = UIColor.TTPinkColor;

    self.clockDotView.backgroundColor = UIColor.TTLightGreyColor;
    self.clockDotView.layer.cornerRadius = 6;
    self.clockDotView.layer.masksToBounds = YES;
}

- (void)setUpObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tickTockDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tickTockDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)tickTockDidEnterBackground {
    [self hideControls];
}

- (void)tickTockDidBecomeActive {
    if (self.analogClock.isHidden) {
        [self.analogClock reloadClock];
    }
    [self showControlsAnimated:YES];
}

- (void)hideControls {
    self.analogClock.alpha = hiddenAlpha;
    self.clockDotView.alpha = hiddenAlpha;
    self.digitalTimeContainer.alpha = hiddenAlpha;
    self.analogClock.hidden = YES;
}

- (void)showControlsAnimated:(BOOL)animated {
    CGFloat duration = (animated) ? 1.0f : 0.0f;
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.analogClock.hidden = NO;
                         self.analogClock.alpha = visibileAlpha;
                         self.clockDotView.alpha = visibileAlpha;
                         self.digitalTimeContainer.alpha = visibileAlpha;
                     }
                     completion:nil];
}

#pragma mark - BEMAnalogClock Delegate Methods

- (CGFloat)analogClock:(BEMAnalogClockView *)clock graduationLengthForIndex:(NSInteger)index {
    return 0.0f;
}

- (UIColor *)analogClock:(BEMAnalogClockView *)clock graduationColorForIndex:(NSInteger)index {
    return UIColor.clearColor;
}

- (void)currentTimeOnClock:(BEMAnalogClockView *)clock Hours:(NSString *)hours Minutes:(NSString *)minutes Seconds:(NSString *)seconds {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];

    self.hoursLabel.text = [NSString stringWithFormat:@"%02d", components.hour];
    self.minutesLabel.text = [NSString stringWithFormat:@"%02d", components.minute];
}

@end
