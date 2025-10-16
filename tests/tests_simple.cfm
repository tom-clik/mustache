<!--- 

# basic mustache tests

Shows Mustache basic operations

## Usage

preview to render template as shown

--->
<cfscript>
mustache = new mustache.Mustache();
template = "
	
	<headline>{{article.headline}}</headline>
	<author>{{article.author}}</author>
	<country>{{country}}</country>
	{{##notshown}}<notshown>{{notshown}}</notshown>{{/notshown}}
	{{##simplebool}}No{{/simplebool}}
	{{##simplebool2}}Yes{{/simplebool2}}
";

context = {};
context.simplebool = false;
context.simplebool2 = true;

context['country'] = 'England';
context.article = {headline="Man bites dog",author="Lunchtime O'Booze",test="test"};
writeOutput("#htmlEditFormat(mustache.render(template=template, context=context,partials={}))#");
</cfscript>