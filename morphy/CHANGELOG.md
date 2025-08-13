## 1.4.1
- fixed bug with String2

## 1.4.0
- recreatable objects using String2

## 1.3.0
- bug fixes, subclass with no members now works, generic copy with bug now fixed where type is incorrect
- in order to fix the above problem the type returned from the copywith is now the type of the named copywith function, eg b.copyWith_A now returns an A type
- this is a BREAKING change.
- if you specify D newD = d.copyWith_A(); then newD will be of type D not A and you'll receive an error
- the thing is that if you know it is a d type you'd more likely do a d.copyWith_D() so this should not be a problem

## 1.2.0
- New functionality - private getters are now allowed!

## 1.1.0
- Breaking change! copywith / change to, the Opt class has been removed and now we favour the () => syntax for optional parameters 

## 1.0.8
- change_to added for a subclass to change the type back to a superclass

## 1.0.7
- morphy_annotation must now be in the dependencies and morphy must be in the dev dependencies, cleaned this up

## 1.0.6
- Abstract classes are now sealed, additional option in annotation to specify non sealed abastract classes

## 1.0.5
- Fixed bug introduced with change to custom constructors

## 1.0.4
- Relaxed dependency versions
- Fixed bug for abstract class json serialize & deserialize

## 1.0.3
- Relaxed analyzer requiremenst to 6.0.0

## 1.0.2
- Added jsonserialization annotation dependency included in morphy

## 1.0.1
- Added jsonserialization dependency included in morphy

## 1.0.0+1
- Updated documentation

## 1.0.0
- First published version