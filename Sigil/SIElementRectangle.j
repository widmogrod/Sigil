@import <Foundation/CPObject.j>

@implementation SIElement : CPObject
{
	// wartość elementu
	CPString value @accessors;
	
	// wysokość i szerokość
	(unsigned int) width @accessors;
	(unsigned int) height @accessors;

	// położenie (x,y)
	(unsigned int) positionX @accessors;
	(unsigned int) positionY @accessors;
	
	CPTextField _textField;
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
		_textField =  [[CPTextField alloc] initWithFrame:CGRectMakeZero()]; 
 
	}

	return self;
}

- (void)willDrawInView:(SIElementsView)anView
{
	var rect = CGRectMake(positionX, positionY, width, height);

	[_textField setFrame:rect];
	
	/*
		TODO: Czy poniższe elemnty nie powinny być owiniete w metodę z lazy load?
	*/
	[_textField setObjectValue:value]; 
	[_textField setBezeled:YES]; 
    [_textField setEditable:NO]; 
    [_textField sizeToFit];
    
	[anView addSubview:_textField];
}

@end
