# attribute sets {#sec-functions-library-attrsets}


## `lib.attrsets.generate` {#function-library-lib.attrsets.generate}

Generate an attribute set from a list of values

### Example

```nix
generate ["a" "b" "c"] (v: {"${v}1"=v;"${v}2"=v;})
=>
{a1="a";a2="a";b1="b";b2="b";c1="c";c2="c";}
```

### Type

```
generate :: [Any] -> (Any -> AttrSet) -> AttrSet
```

### Arguments

values
: List of values

generator
: A function transforming a single value into an attribute set

## `lib.attrsets.merge` {#function-library-lib.attrsets.merge}

Deep merge two attribute sets

### Example

```nix
merge {a="a";c={c1="c1";}} {b="b";c={c2="c2";}}
=>
{a="a";b="b";c={c1="c1";c2="c2";}}
```

### Type

```
merge :: AttrSet -> AttrSet -> AttrSet
```

### Arguments

left
: Left attribute set

right
: Right attribute set


