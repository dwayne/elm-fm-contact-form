module Data.Contact.QueryType exposing
    ( Error
    , QueryType(..)
    , fieldType
    , fromString
    , toString
    )

import Field.Advanced as F


type QueryType
    = General
    | Support


type alias Error =
    F.Error Never


fromString : String -> Result Error QueryType
fromString =
    F.trim
        (\s ->
            case s of
                "general" ->
                    Ok General

                "support" ->
                    Ok Support

                _ ->
                    Err (F.validationError s)
        )


toString : QueryType -> String
toString q =
    case q of
        General ->
            "general"

        Support ->
            "support"


fieldType : F.Type Error QueryType
fieldType =
    F.customType
        { fromString = fromString
        , toString = toString
        }
