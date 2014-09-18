//
//  EJHPersistentViewController.m
//  BePersistent
//
//  Created by Emily Hoehne on 9/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "EJHPersistentViewController.h"
static NSString * const scoreKey = @"scoreKey";
static NSString * const playerKey = @"playerKey";
static NSString * const playerNameKey = @"playerNameKey";


@interface EJHPersistentViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *number;

@end

@implementation EJHPersistentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textField.delegate = self;
    
    NSDictionary *player = [[NSUserDefaults standardUserDefaults] objectForKey:playerKey];
    [self updateWithDictionary:player];

}

- (void)updateWithDictionary: (NSDictionary *)dictionary {
    NSNumber  *scoreNew = dictionary[scoreKey];
    if (scoreNew) {
        self.number.text = [scoreNew stringValue];
        self.stepper.value = [scoreNew doubleValue];
    }
    NSString *name = dictionary[playerKey];
    if (name) {
        self.textField.text = name;
    }
    
}
- (IBAction)changeScore:(id)sender {
    //This allows the score to change up and down based upon stepper direction clicked.
    int value = [self.stepper value];
    self.number.text = [NSString stringWithFormat:@"%d", value];
}
- (IBAction)save:(id)sender {
     //This is how you store.
 
    NSMutableDictionary *player = [NSMutableDictionary new];
    if (self.textField.text){
        [player setObject:self.textField.text forKey:playerNameKey];
    }
    [player setObject:@(self.stepper.value) forKey:scoreKey];
    [[NSUserDefaults standardUserDefaults] setObject:player forKey:playerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@(self.stepper.value) forKey:scoreKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
