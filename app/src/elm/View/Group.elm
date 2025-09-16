module View.Group exposing (view)

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic


view : List (H.Attribute msg) -> List (H.Html msg) -> H.Html msg
view =
    Generic.view
        { element = H.div
        , preAttrs =
            [ HA.class "group"
            ]
        , postAttrs =
            []
        }
