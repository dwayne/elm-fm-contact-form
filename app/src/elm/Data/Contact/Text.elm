module Data.Contact.Text exposing
    ( CustomError(..)
    , Error
    , Text
    , fieldType
    , fromString
    , toString
    )

import Field.Advanced as F


type Text
    = Text String


type alias Error =
    F.Error CustomError


type CustomError
    = TooShort { actual : Int, min : Int }
    | TooLong { actual : Int, max : Int }


fromString : { min : Int, max : Int } -> String -> Result Error Text
fromString options =
    let
        max =
            Basics.max 1 options.max

        min =
            Basics.min max (Basics.max 1 options.min)
    in
    F.trim
        (\s ->
            let
                n =
                    String.length s
            in
            if n < min then
                Err (F.customError <| TooShort { actual = n, min = min })

            else if n > max then
                Err (F.customError <| TooLong { actual = n, max = max })

            else
                Ok (Text s)
        )


toString : Text -> String
toString (Text s) =
    s


fieldType : { min : Int, max : Int } -> F.Type Error Text
fieldType options =
    F.customType
        { fromString = fromString options
        , toString = toString
        }
