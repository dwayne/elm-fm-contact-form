module View.LabelledRadio exposing (ViewOptions, view)

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic
import View.Radio as Radio


type alias ViewOptions msg =
    { text : String
    , radioAttrs : List (H.Attribute msg)
    }


view : ViewOptions msg -> List (H.Attribute msg) -> H.Html msg
view { text, radioAttrs } attrs =
    Generic.view
        { element = H.label
        , preAttrs =
            [ HA.class "labelled-radio"
            ]
        , postAttrs = []
        }
        attrs
        [ Radio.view radioAttrs
        , H.text text
        ]
