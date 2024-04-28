let b
    : Bool
    = True

let n
    : Natural
    = 1

let s
    : Text
    = "foo"

let u = < u1 | u2 >

let test =
        assert
      : let actual
            : Natural
            = 1 + 2

        let expected
            : Natural
            = 3

        in  expected === actual

in  { b, n, s, u }
