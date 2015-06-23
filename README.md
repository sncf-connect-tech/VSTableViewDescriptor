<p align="center" >
  <img src="https://raw.github.com/voyages-sncf-technologies/VSTableViewDescriptor/assets/header.png" alt="TableViewDescriptor" title="TableViewDescriptor">
</p>

TableViewDescriptor is a library in order to structure your UITableview implementation in a data-oriented way instead of index-oriented.

## Get Started

Instead of using the index-oriented method to describe your TableView, use the data-oriented way proposed by TableViewDescriptor.
TableViewDescriptor is using blocks instead of implemeting methods from ```UITableViewDataSource``` and ```UITableViewDelegate``` like ```heightForRowAtIndexPath:``` or ```cellForRowAtIndexPath:``` 

### Setup

Instanciate a TableViewDescriptor then set it as the delegate and datasource of the tableView:
```objective-c
self.tableViewDescriptor = [[VSTableViewDescriptor alloc] init];
self.tableView.delegate = self.tableViewDescriptor;
self.tableView.dataSource = self.tableViewDescriptor;
```

### Section

Adding a title section is very straightforward:
```objective-c
VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView* tableView, int section)
{
	return @"Section Title";
}];
[self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
```

Empty section:
```objective-c
VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
[self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
```


### Cell

Browse your model and add cells in the tableView:
```objective-c
__weak typeof(self) weakSelf = self; // important, use weak self in block
for (ModelElement* element in self.myModel)
{
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView* tableView, NSIndexPath *indexPath)
    {
        return [VSCellViewTableViewCell height:element];

    } configure:^UITableViewCell *(UITableView* tableView, NSIndexPath *indexPath)
    {
        VSCellViewTableViewCell* cell = (VSCellViewTableViewCell*)[weakSelf.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
        [cell configure:element];
        return cell;

    } select:^(UITableView* tableView, NSIndexPath *indexPath)
    {
        [weakSelf onTap:element];
    }];
    [sectionDescriptor addCellDescriptor:cellDescriptor];
}
```

Et voilà !

### More

TableViewDescriptor doesn't implement all delegate and datasource methods of UITableView. You can use your controller as delegate at the same time using TableViewDescriptor for the missing methods or contribute to the project :).
```objective-c
self.tableViewDescriptor.dataSource = self;
self.tableViewDescriptor.delegate = self;
```

Methods implemented by TableViewDescriptor:
- Sections
    - ```(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView```
    - ```(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section```
    - ```(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section```
    - ```(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section```
    - ```(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section```
    - ```(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section```
    - ```(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section```
    - ```(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section```
- Cells
    - ```(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath```
    - ```(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath```
    - ```(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath```
    - ```(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath```
    - ```(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath```
    - ```(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath```

If you override in your controller a method you implemented via the TableViewDescriptor, a warning is fired in the console.
```objective-c
VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
//...
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // console output: WARNING : YourController overrides VSTableViewDescriptor::numberOfSectionsInTableView:
}
```


## Installation

### Installation with CocoaPods

Copy and paste the following lines to your PodFile file:  
    
    source 'https://github.com/CocoaPods/Specs.git'
    pod 'TableViewDescriptor'

### Manual installation

- [Download](https://github.com/voyages-sncf-technologies/VSTableViewDescriptor/releases) the last release of TableViewDescriptor.
- Import the folder *VSTableViewDescriptor* into your project.

### Sample

You may download the project to have a look at the integrated sample.


## Credits

TableViewDescriptor is owned and maintained by [Voyages-sncf.com](http://www.voyages-sncf.com/).

TableViewDescriptor was originally created by [Gwenn Guihal](https://github.com/myrddinus).


## License

TableViewDescriptor is released under the MIT license.
