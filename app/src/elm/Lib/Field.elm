module Lib.Field exposing (toAttrs)

import Field.Advanced as F exposing (Field)
import Html as H
import Html.Attributes as HA


toAttrs : Field e a -> List (H.Attribute msg)
toAttrs field =
    [ HA.value (F.toRawString field)
    , HA.attribute "data-state" <|
        if F.isClean field then
            "clean"

        else
            "dirty"
    , HA.attribute "data-validity" <|
        if F.isValid field then
            "valid"

        else
            "invalid"
    ]
