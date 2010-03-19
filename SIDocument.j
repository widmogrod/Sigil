@import <AppKit/CPDocument.j>

@import "SIWindowController.j";
@import "Sigil/SIElementText.j";

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

    	var firstElement = [[SIElementText alloc] init];
    	[firstElement setValue:@"To jest testowa wartość1111"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[firstElement setWidth:200];
    	[firstElement setHeight:60];
    	[firstElement setPositionX:100];
    	[firstElement setPositionY:100];
    	
    	[_elements addObject:firstElement];
    	
    	var secondElement = [[SIElementText alloc] init];
    	[secondElement setValue:@"To jest testowa wartość2222"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[secondElement setWidth:200];
    	[secondElement setHeight:60];
    	[secondElement setPositionX:200];
    	[secondElement setPositionY:300];
    	
    	
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
