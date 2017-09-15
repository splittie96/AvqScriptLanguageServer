/*
 * generated by Xtext 2.12.0
 */
package org.xtext.avqscript.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.avqscript.avqScript.ScriptPackage

@RunWith(XtextRunner)
@InjectWith(AvqScriptInjectorProvider)
class AvqScriptParsingTest {
	@Inject
	ParseHelper<ScriptPackage> parseHelper
	
	@Test
	def void loadModel() {
		val result = parseHelper.parse('''
			script package blah
			end blah
		''')
		Assert.assertNotNull(result)
		Assert.assertTrue(result.eResource.errors.isEmpty)
	}
}
