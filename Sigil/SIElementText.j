@import <AppKit/CPFont.j>;
@import "SIElement.j"
@import "SIOptionText.j"

@implementation SIElementText : SIElement
{
	CPTextField 	_textField;
	(unsigned int) 	_fontSize;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		_fontSize  = 18;
		
		_textField =  [[CPTextField alloc] initWithFrame:CGRectMakeZero()]; 
		
		[_textField setFont:[CPFont boldSystemFontOfSize:_fontSize]];
	}

	return self;
}

-(void)setScaleProportions:(CGSize)aSize
{
	[_textField setFont:[CPFont boldSystemFontOfSize:_fontSize * aSize.width]];
	[_textField sizeToFit];
	//var size = [_textField frameSize];
	
	_width += (_width*aSize.width);
	_height += (_height*aSize.height);
	
	//[_textField setFrameSize:size];
	
	//console.log("setScaleProportions", _textSize * aSize.width, aSize);
	//var font = [CPFont fontWithName:@"" size:];
	//var font = [CPFont systemFontOfSize:_textSize * aSize.width];

	//_value = [_value sizeWithFont:[CPFont systemFontOfSize:18] inWidth:_width];

	//_value = [_value sizeWithFont:[CPFont systemFontOfSize:18]];

	//[_textField setStringValue:_value];
	//[self draw];
}

- (void)willDrawInView:(SIElementsView)anView
{
	//[super willDrawInView:anView];

	[_textField setFrame: [self rect]];
	
	/*
		TODO: Czy poniższe elemnty nie powinny być owiniete w metodę z lazy load?
			  - Być może tak i do tego funkcjonalność rysowania powinna również
			    zostać zaimplementowana w {@see SIElement};
	*/
	[_textField setObjectValue:_value]; 
	[_textField setBezeled:NO]; 
    [_textField setEditable:NO];
    [_textField setBordered:NO];
    [_textField sizeToFit];
    
	[anView addSubview:_textField];
	/*
	[[_anView superview] addSubview:self
							   positioned:CPWindowBelow
							   relativeTo:_elementsView];
	*/
}

- (CPArray)elementOptions
{
	var text = [[SIOptionText alloc] initWithElement:self];

	return [text];
}
@end
