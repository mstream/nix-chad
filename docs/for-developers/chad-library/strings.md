# strings manipulation {#sec-functions-library-strings}


## `lib.strings.camelToKebabCase` {#function-library-lib.strings.camelToKebabCase}

Convert camel-case string to kebab-case string

### Example

```nix
camelToKebabCase "fooBar"
=>
"foo-bar"
```

### Type

```
camelToKebabCase :: String -> String
```

### Arguments

input
: Input string

## `lib.strings.camelToSnakeCase` {#function-library-lib.strings.camelToSnakeCase}

Convert camel-case string to snake-case string

### Example

```nix
camelToSnakeCase "fooBar"
=>
"foo_bar"
```

### Type

```
camelToSnakeCase :: String -> String
```

### Arguments

input
: Input string


