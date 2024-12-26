{- This is a single line comment. -}

{- This is
   a multi-line
   comment.
-}
let std =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/dc1177275498acbbe433a8e0d5b834ad27ecfce1/Prelude/package.dhall
        sha256:931cbfae9d746c4611b07633ab1e547637ab4ba138b16bf65ef1b9ad66a60b7f

let x = 1

let boolValue
    : Bool
    = True

let naturalValue
    : Natural
    = 1

let textValue
    : Text
    = "foo"

let function
    : Text -> Text
    = \(text : Text) -> "${text}${text}"

let functionExample =
      let actual
          : Text
          = function "abc"

      let expected
          : Text
          = "abcabc"

      in  assert : expected === actual

let Union = < u1 | u2 >

let showUnion
    : Union -> Text
    = \(union : Union) -> merge { u1 = "u1", u2 = "u1" } union

let example =
      let actual
          : Natural
          = 1 + 2

      let expected
          : Natural
          = 3

      in  assert : expected === actual

let nestedFunction
    : Natural -> Natural
    = \(n : Natural) ->
        let array1
            : List Natural
            = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

        let array2
            : List Natural
            = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

        let array3
            : List Natural
            = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

        let level1
            : Natural -> Natural
            = \(n1 : Natural) ->
                let level2
                    : Natural -> Natural
                    = \(n2 : Natural) ->
                        let level3
                            : Natural -> Natural
                            = \(n3 : Natural) ->
                                let level4
                                    : Natural -> Natural
                                    = \(n4 : Natural) -> n4

                                in  level4 n3

                        in  level3 n2

                in  level2 n1

        in  std.List.foldLeft
              Natural
              (std.List.concat Natural [ array1, array2, array3 ])
              Natural
              (\(acc : Natural) -> \(x : Natural) -> acc + x)
              (level1 n)

in  { Union
    , boolValue
    , function
    , naturalValue
    , nestedFunction
    , showUnion
    , textValue
    }
