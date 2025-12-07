# KDL file format utils {#sec-functions-library-kdl}


## `lib.kdl.key` {#function-library-lib.kdl.key}

Generate a key with given name and arguments

### Example

```nix
key {name="foo";args=["bar" 123];}
=>
"foo \"bar\" 123"
```

### Type

```
key :: AttrSet -> String
```

### Arguments

config
: Config containing name and arguments


