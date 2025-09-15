module View.Label exposing (ViewOptions, view)

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic


type alias ViewOptions =
    { id : String
    , title : String
    , isRequired : Bool
    }


view : ViewOptions -> List (H.Attribute msg) -> H.Html msg
view { id, title, isRequired } attrs =
    Generic.view
        { element = H.label
        , preAttrs =
            [ HA.class "label"
            ]
        , postAttrs =
            [ HA.for id
            ]
        }
        attrs
        ([ H.text title
         ]
            ++ (if isRequired then
                    [ H.span [ HA.class "fg-green-600" ] [ H.text "*" ]
                    ]

                else
                    []
               )
        )
