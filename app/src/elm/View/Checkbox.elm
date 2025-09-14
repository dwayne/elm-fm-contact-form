module View.Checkbox exposing (view)

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic


view : List (H.Attribute msg) -> H.Html msg
view attrs =
    Generic.view
        { element = H.input
        , preAttrs =
            [ HA.class "input"
            ]
        , postAttrs =
            [ HA.type_ "checkbox"
            ]
        }
        attrs
        []
