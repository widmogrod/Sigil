@import <AppKit/CPWindowController.j>
@import <AppKit/CPView.j>

@implementation SIWindowController: CPWindowController
{}

- (void) init
{
	var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(150.0, 57.0, 500.0, 200.0)
												styleMask:CPBorderlessWindowMask],
		contentView = [theWindow contentView],
		bounds = [contentView bounds];


	var contentArea = [[CPView alloc] initWithFrame:CGRectMake(5.0, 5.0, CGRectGetWidth(bounds)-15, CGRectGetHeight(bounds)-15)];
    [contentArea setBackgroundColor:[CPColor redColor]];
    
    // This view will grow in both height an width.
    [contentArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    // This view will grow in both height an width.
	[theWindow setAutoresizingMask:CPViewMaxXMargin | CPViewMaxYMargin | CPViewMinXMargin | CPViewMinYMargin | CPViewWidthSizable];	
	
	[contentView addSubview:contentArea];
	//[theWindow makeFirstResponder:contentView];

	console.log([theWindow isMainWindow]);

	self = [super initWithWindow:theWindow];
	
	if (self)
	{
	}
	
	return self;
}

@end
