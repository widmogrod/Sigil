@import <AppKit/CPDocument.j>

@import "SIWindowController.j";
@import "Sigil/SIElement.j";

@implementation SIDocument : CPDocument
{
	CPSet _elements;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
    	_elements = [CPSet set];

    	var firstElement = [[SIElement alloc] init];
    	[firstElement setValue:@"To jest testowa wartość1111"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[firstElement setWidth:200];
    	[firstElement setHeight:30];
    	[firstElement setPositionX:30];
    	[firstElement setPositionY:30];
    	
    	[_elements addObject:firstElement];
    	
    	var secondElement = [[SIElement alloc] init];
    	[secondElement setValue:@"To jest testowa wartość2222"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[secondElement setWidth:200];
    	[secondElement setHeight:30];
    	[secondElement setPositionX:30];
    	[secondElement setPositionY:30];
    	
    	
		[_elements addObject:secondElement];
		
		console.log('SIDocument', [_elements count])
    }
    
    return self;
}

- (CPSet)elements
{
	return _elements;
}

- (void)makeWindowControllers
{
	var windowController = [[SIWindowController alloc] init];
	[self addWindowController: windowController];
}


@end
