package org.xtext.avqscript

import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.naming.QualifiedName
import org.xtext.avqscript.avqScript.FunctionDeclaration

class QualifiedNameProvider extends IQualifiedNameProvider.AbstractImpl {
	
	override getFullyQualifiedName(EObject obj) {
		if (obj instanceof FunctionDeclaration) {
			return QualifiedName.create(obj.name) 
		}
		return null
	}
	
}
