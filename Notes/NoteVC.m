//
//  DetailVC.m
//  Notes
//
//  Created by Maksym Poliakov on 09.11.16.
//  Copyright © 2016 Maksym Poliakov. All rights reserved.
//

#import "NoteVC.h"
#import "ListVC.h"

@interface NoteVC () <UITextFieldDelegate>

@property UILabel *titleLabel;
@property UITextField *titleTextField;
@property UIView *dividerView;
@property UITextView *noteTextView;
@property UIBarButtonItem *saveButton;
@property NSMutableDictionary *notes;

@end

@implementation NoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRightBarButtonItem];
    [self initTitleLabel];
    [self initTitileTextField];
    [self initDividerView];
    [self initNoteTextView];
}

- (void) viewWillAppear:(BOOL)animated {
    self.title = @"Note";
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillLayoutSubviews; {
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0].active = true;
    [self.titleLabel.widthAnchor constraintEqualToConstant:50.0].active = true;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:navBarHeight + statusBarHeight + 20.0].active = true;
    
    self.titleTextField.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleTextField.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:8.0].active = true;
    [self.titleTextField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0].active = true;
    [self.titleTextField.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:navBarHeight + statusBarHeight + 20.0].active = true;
    
    self.dividerView.translatesAutoresizingMaskIntoConstraints = false;
    [self.dividerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.dividerView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8.0].active = true;
    [self.dividerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.dividerView.heightAnchor constraintEqualToConstant:1.0].active = true;
    
    self.noteTextView.translatesAutoresizingMaskIntoConstraints = false;
    [self.noteTextView.topAnchor constraintEqualToAnchor:self.dividerView.bottomAnchor constant:8.0].active = true;
    [self.noteTextView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20.0].active = true;
    [self.noteTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8.0].active = true;
    [self.noteTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-8.0].active = true;

}

#pragma mark - init subviews

- (void) initNoteTextView; {
    self.noteTextView = [[UITextView alloc] init];
    self.noteTextView.userInteractionEnabled = YES;
    self.noteTextView.text = self.noteContent;
    [self.view addSubview:self.noteTextView];
}

- (void) initDividerView; {
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.dividerView];
}

- (void) initTitileTextField; {
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.delegate = self;
    self.titleTextField.placeholder = @"Enter note title here";
    self.titleTextField.text = self.noteTitle;
    self.titleTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.titleTextField];
}

- (void) initTitleLabel; {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.text = @"Title:";
    [self.view addSubview:self.titleLabel];

}

- (void) initRightBarButtonItem; {
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNote)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
}

#pragma mark - actions

- (void) saveNote; {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedNotes"] == nil) {
        self.notes = [NSMutableDictionary dictionary];
    } else {
        self.notes = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedNotes"] mutableCopy];
    }
    if (self.titleTextField.text != nil) {
        [self.notes setValue:self.noteTextView.text forKey:self.titleTextField.text];
        [[NSUserDefaults standardUserDefaults] setObject:self.notes forKey:@"savedNotes"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"titleTextField text is nil");
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField; {
    if ([textField isEqual:self.titleTextField]) {
        [self.titleTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField; {
    if ([textField isEqual:self.titleTextField]) {
        self.titleTextField.placeholder = @"";
    }
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField; {
    if ([textField isEqual:self.titleTextField] && [textField.text isEqualToString:@""]) {
        self.titleTextField.placeholder = @"Enter note title here";
    }
    return YES;
}

@end
