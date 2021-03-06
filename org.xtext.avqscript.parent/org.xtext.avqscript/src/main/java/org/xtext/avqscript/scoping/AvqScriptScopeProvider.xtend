/*
 * generated by Xtext 2.12.0
 */
package org.xtext.avqscript.scoping

import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.xtext.avqscript.avqScript.FeatureCall
import org.xtext.avqscript.avqScript.AvqScriptPackage
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.scoping.Scopes
import org.xtext.avqscript.avqScript.FunctionDeclaration
import org.xtext.avqscript.avqScript.ScriptPackage

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class AvqScriptScopeProvider extends AbstractAvqScriptScopeProvider {

	override getScope(EObject context, EReference reference) {
		if (context instanceof FeatureCall && reference === AvqScriptPackage.Literals.FEATURE_CALL__TARGET) {
			val rootElement = EcoreUtil2.getRootContainer(context)
			val candidates = EcoreUtil2.getAllContentsOfType(rootElement, FunctionDeclaration)
			if ((context as FeatureCall).args.empty) {
				return Scopes.scopeFor(candidates)
			} else {
				val arglist = (context as FeatureCall).args
				return Scopes.scopeFor(candidates.filter[it.params.length == arglist.length])
			}
		}

		if (context instanceof FeatureCall && reference === AvqScriptPackage.Literals.FEATURE_CALL__ARGS) {
			val elements = newArrayList()
			elements.addAll(EcoreUtil2.getContainerOfType(context, FunctionDeclaration)?.localVars)
			elements.addAll(EcoreUtil2.getContainerOfType(context, FunctionDeclaration)?.params)
			elements.addAll(EcoreUtil2.getContainerOfType(context, ScriptPackage)?.globalVars)
			return Scopes.scopeFor(elements)
		}
		return super.getScope(context, reference)
	}

}
