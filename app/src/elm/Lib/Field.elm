module Lib.Field exposing (toAttrs)

import Field.Advanced as F exposing (Field)
import Html as H
import Html.Attributes as HA


type alias Attributes msg =
    { value : H.Attribute msg
    , data :
        { state : H.Attribute msg
        , validity : H.Attribute msg
        }
    }


toAttrs : Field e a -> Attributes msg
toAttrs field =
    { value = HA.value (F.toRawString field)
    , data =
        { state =
            HA.attribute "data-state" <|
                if F.isClean field then
                    "clean"

                else
                    "dirty"
        , validity =
            HA.attribute "data-validity" <|
                if F.isValid field then
                    "valid"

                else
                    "invalid"
        }
    }
