<!--- 

# basic mustache tests

Shows Mustache basic operations

## Usage

preview to render templates as shown

--->

<cfset mustache = createObject("component", "mustache.Mustache").init()>
<cfset context = structNew()>

<cfset "partials" = {
	"image"="<div class=""imageWrap"">{{##showImages}}{{>linkStartIf}}
		<img src=""{{thumb_src}}"" class=""contentItemImage {{extraClass}}"" title=""{{titleAttr}}""
				width=""{{imgWidth}}"" {{##imgHeight}}height=""{{imgHeight}}""{{/imgHeight}} {{##id}}id=""{{id}}""{{/id}}/>
		{{>linkEndIf}}{{/showImages}}</div>"
	,"title"="{{##showTitle}}<h3 class=""title{{##extraClass}} {{extraClass}}{{/extraClass}}"" {{##style}}style=""{{style}}""{{/style}}>{{>linkStartIf}}
		{{##datebeforeheadline}}{{>dateInline}}{{/datebeforeheadline}}
		{{>titleText}}{{>linkEndIf}}</h3>{{/showTitle}}"
	,"titleText"="{{{text}}}"
	,"description"="<div class=""textWrap{{##extraClass}} {{extraClass}}{{/extraClass}}"" {{##style}}style=""{{style}}""{{/style}}>{{##showDescription}}
		{{##datebeforedescription}}{{>dateInline}}{{/datebeforedescription}}
		{{>descriptionText}} {{>link}}{{/showDescription}}</div>"
	,"descriptionText"="{{{text}}}"
	,"author"="{{##showAuthor}}<div class=""contentitemAuthor"">{{>authorPrefix}}{{##useAuthorLink}}<a href=""{{>authorLink}}"">{{/useAuthorLink}}{{>authorText}}{{##useAuthorLink}}</a>{{/useAuthorLink}}</div>{{/showAuthor}}"
	,"authorText"="{{{text}}}"
	,"authorLink"="{{{link}}}"
	,"authorPrefix"=""
	,"linkStartIf"="{{##useLinks}}{{>linkStart}}{{/useLinks}}"
	,"linkEndIf"="{{##useLinks}}{{>linkEnd}}{{/useLinks}}"
	,"linkStart"="<a class=""articleLink {{extraClass}}"" {{##target}}target=""{{target}}""{{/target}} href=""{{url}}"">"
	,"linkEnd"="</a>"
	,"link"="{{##showLinks}}<span class=""articleLink"">{{{textBefore}}}{{>linkStart}}{{>linkText}}{{>linkEnd}}</span>{{/showLinks}}"
	,"linkText"="{{{text}}}"
	,"dateInline"="{{##showDates}}{{>dateText}} {{{dateSeparator}}} {{/showDates}}"
	,"dateSeparate"="{{##showDates}}<p class=""contentitemDate"">{{>dateText}}</p>{{/showDates}}"
	,"dateText"="{{{date}}}"
}>

<cfsavecontent variable="template">
{{#imagebeforeheadline}}{{>image}}{{/imagebeforeheadline}}
{{>title}}
{{#imageafterheadline}}{{>image}}{{/imageafterheadline}}
{{#dateafterheadline}}{{>dateSeparate}}{{/dateafterheadline}}
{{#imagebeforedescription}}{{>image}}{{/imagebeforedescription}}
{{>description}}
{{#linkafterdescription}}{{>link}}{{/linkafterdescription}}
{{#imageafterdescription}}{{>image}}{{/imageafterdescription}}
{{#dateafterdescription}}{{>dateSeparate}}{{/dateafterdescription}}
{{>author}}
</cfsavecontent>

<cfset date = "20/03/2007">
<cfset context.imagebeforeheadline = 0>
<cfset context.imageafterheadline = 1>
<cfset context.imagebeforedescription = 0>
<cfset context.imageafterdescription = 0>
<cfset context.dateafterheadline = 0>

<!--- <cfset context.image="<div class=""imageWrap"">{{##showImages}}{{>linkStartIf}}
		<img src=""{{thumb_src}}"" class=""contentItemImage {{extraClass}}"" title=""{{titleAttr}}""
				width=""{{imgWidth}}"" {{##imgHeight}}height=""{{imgHeight}}""{{/imgHeight}} {{##id}}id=""{{id}}""{{/id}}/>
		{{>linkEndIf}}{{/showImages}}</div>"> --->


<cfoutput>#htmlEditFormat(mustache.render(template=template, context=context,partials=partials))#</cfoutput>

<cfset context['country'] = 'England'>
<cfset context.article = {headline="Man bites dog",author="Lunchtime O'Booze",test="test"}>

<cfoutput>#htmlEditFormat(mustache.render(template=template, context=context,partials=partials))#</cfoutput>
