<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="setup">
		<cfset partials = {} />
	</cffunction>
	
	<cffunction name="missingPartialErrorThrown">
		<cfset expectException("Mustache.TemplateMissing")/>

		<cfset stache = createObject("component", "mustache.Mustache").init() />
		<cfset context = { word = 'Goodnight', name = 'Gracie' }/>
		<cfset template = "<ul><li>Say {{word}}, {{name}}.</li><li>{{> gracie_allen}}</li></ul>"/>
		<cfset expected = "<ul><li>Say Goodnight, Gracie.</li><li>Goodnight</li></ul>"/>
		<cfset stache.render(template, context, partials)>
	</cffunction>

	<cffunction name="missingPartialSilentFailure">
		<cfset stache = createObject("component", "mustache.Mustache").init(raiseErrors=false) />
		<cfset context = { word = 'Goodnight', name = 'Gracie' }/>
		<cfset template = "<ul><li>Say {{word}}, {{name}}.</li><li>{{> gracie_allen}}</li></ul>"/>
		<cfset expected = "<ul><li>Say Goodnight, Gracie.</li><li></li></ul>"/>
		<cfset assertEquals(expected, stache.render(template, context))/>
	</cffunction>
	
	<cffunction name="missingTemplateErrorThrown">
		<cfset expectException("Mustache.TemplateMissing")/>

		<cfset stache = createObject("component", "mustache.Mustache").init() />
		<cfset stache.render()>
	</cffunction>

	<cffunction name="missingTemplateSilentFailure">
		<cfset stache = createObject("component", "mustache.Mustache").init(raiseErrors=false) />
		<cfset assertEquals("", stache.render())/>
	</cffunction>
	
</cfcomponent>