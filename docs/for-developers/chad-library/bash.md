# bash code generation helpers {#sec-functions-library-bash}


## `lib.bash.catchErrorExec` {#function-library-lib.bash.catchErrorExec}

Generate bash code which executes a sequence of commands and
stores their standard output and return code in cmd_out and
cmd_ret variables.

### Example

```nix
catchErrorExec ["foo" "bar" "baz"]
=>
"set +e;cmd_out=$(foo bar baz 2>&1);cmd_ret=$?;set -e"
```

### Type

```
catchErrorExec :: [String] -> String
```

### Arguments

commands
: List of commands to be executed

## `lib.bash.command` {#function-library-lib.bash.command}

Generate bash code representing program invocation command

### Example

```nix
command {flags=["foo"];parameters={bar="baz";};program="qux";}
=>
"qux --foo --bar baz"
```

### Type

```
options :: AttrSet -> String
```

### Arguments

config
: Configuration including flags and parameters and program path

## `lib.bash.echoError` {#function-library-lib.bash.echoError}

Generate bash code printing a message into standard error stream

### Example

```nix
echoError "foo bar"
=>
"echo \"foo bar\" >&2"
```

### Type

```
echoError :: String -> String
```

### Arguments

message
: Message to be printed

## `lib.bash.matchPattern` {#function-library-lib.bash.matchPattern}

Generate bash code which matches a text against a pattern

### Example

```nix
matchPattern {pattern="a([[:lower:]])c?";text="ab";}
=>
"[p \"ab\" =~ a([[:lower:]])c? ]]"
```

### Type

```
echoError :: AttrSet -> String
```

### Arguments

config
: Configuration including pattern and text

## `lib.bash.options` {#function-library-lib.bash.options}

Generate bash code representing command options

### Example

```nix
options {flags=["foo"];parameters={bar="baz";};}
=>
"--foo --bar baz"
```

### Type

```
options :: AttrSet -> String
```

### Arguments

config
: Configuration including flags and parameters


