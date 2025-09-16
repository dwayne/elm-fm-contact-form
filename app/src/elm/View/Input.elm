module View.Input exposing (Type(..), ViewOptions, view)

import Field.Advanced exposing (Field)
import Html as H
import Html.Attributes as HA
import Lib.Field as F
import Lib.View.Generic as Generic


type alias ViewOptions e a =
    { type_ : Type
    , field : Field e a
    }


type Type
    = Text
    | Email


view : ViewOptions e a -> List (H.Attribute msg) -> H.Html msg
view { type_, field } attrs =
    Generic.view
        { element = H.input
        , preAttrs =
            [ HA.class "input"
            ]
        , postAttrs =
            [ HA.type_ <|
                case type_ of
                    Text ->
                        "text"

                    Email ->
                        "email"
            ]
                ++ F.toAttrs field
        }
        attrs
        []
