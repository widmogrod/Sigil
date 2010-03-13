@import <AppKit/CPDocument.j>
@import "SIWindowController.j";

@implementation SIDocument : CPDocument
{}

- (id)init
{
    self = [super init];
    
    if (self)
    {

    }
    
    return self;
}

- (void)makeWindowControllers
{
	var windowController = [[SIWindowController alloc] init];
	[self addWindowController: windowController];
}


@end
