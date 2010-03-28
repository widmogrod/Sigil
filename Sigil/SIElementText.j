@import "SIElement.j"
@import "SIOptionText.j"

@implementation SIElementText : SIElement
{
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
