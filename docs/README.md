
### Module Chart

This is a useful piece of documentation, however we do not all have _Microsoft Visio_ (`.vsdx`). So we will need to identify a readily available, possibly UML capable, charting package. Thankfully, however, there is at least a `.png` output so we have an idea as to the layout of the project.

### Arrays or Tuples

_Pot-ay-to pot-ah-to..._ Yes, we understand that _arrays are arrays_ in _SQF_ (`.sqf`), or [any](https://en.wikipedia.org/wiki/List_of_programming_languages_by_type#Dataflow_languages) basically [_dataflow_](https://en.wikipedia.org/wiki/Dataflow_programming) language. [_Prograph_](https://en.wikipedia.org/wiki/Prograph) is perhaps the most innovative of the bunch; I had the pleasure of working with it back during its original inception. Although _SQF_ is textual, and single threaded, in nature, unlike _Prograph_, on both counts, is both _visual_, and potentially _multi-threaded_, in nature, the concepts are very similar when dealing with potentially _heterogeneous_, not _homogenous_, _arrays_. There is really no notion of [_tuple_](https://en.wikipedia.org/wiki/Tuple), per se, apart from the representation we assign to a given structure. Insofar as this is the case, then we consider _some_ arrays to be _tuples_, _heterogeneous_, with distinct, fit for purpose _elements_. Whereas other arrays are simply enumerated _homogenous_ elements.

### KP Sectors Tuple Matrix

The `kp-sectors-tuple-matrix.ods` file represents a matrix aligning sectors tuples together. There are several types of such tuples we need to maintain, and there needs to be a commonality among the core elements for interoperability at various moments during the framework.

* Start bases
* Forward operating bases
* Sectors
  * Radio towers
  * Factories
  * Townships
  * Capitol cities

