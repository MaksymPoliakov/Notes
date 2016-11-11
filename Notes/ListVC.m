//
//  MainVC.m
//  Notes
//
//  Created by Maksym Poliakov on 09.11.16.
//  Copyright © 2016 Maksym Poliakov. All rights reserved.
//

#import "ListVC.h"
#import "NoteVC.h"

@interface ListVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UIBarButtonItem *addButton;
@property (strong, nonatomic)NSMutableDictionary *notes;

@end

@implementation ListVC

- (void)viewDidLoad; {
    [super viewDidLoad];
    
    [self setupTableView];
    [self initRightBarButtonItem];
    
}

- (void) viewWillAppear:(BOOL)animated; {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedNotes"] == nil) {
        self.notes = [NSMutableDictionary dictionary];
    } else {
        self.notes = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedNotes"];
    }
    self.navigationItem.title = @"List";
    [self.tableView reloadData];
}

#pragma mark - init subviews

- (void) initRightBarButtonItem; {
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = self.addButton;
}

- (void) setupTableView; {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"noteCell"];
}
#pragma mark - actions

-(void)addNote; {
    NoteVC* noteVC = [[NoteVC alloc]init];
    [self showViewController:noteVC sender:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.notes.allKeys[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    NoteVC *noteVC = [[NoteVC alloc]init];
    NSString *noteTitle = self.notes.allKeys[indexPath.row];
    NSString *noteContent = [self.notes valueForKey:noteTitle];
    noteVC.noteTitle = noteTitle;
    noteVC.noteContent = noteContent;
    [self showViewController:noteVC sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *key = self.notes.allKeys[indexPath.row];
        [self.notes removeObjectForKey:key];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
