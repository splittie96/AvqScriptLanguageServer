/*
 * generated by Xtext 2.12.0
 */
package org.xtext.avqscript.ide

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import org.xtext.avqscript.AvqScriptRuntimeModule
import org.xtext.avqscript.AvqScriptStandaloneSetup

/**
 * Initialization support for running Xtext languages as language servers.
 */
class AvqScriptIdeSetup extends AvqScriptStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new AvqScriptRuntimeModule, new AvqScriptIdeModule))
	}
	
}
