module View.LabelledCheckbox exposing (ViewOptions, view)

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic
import View.Checkbox as Checkbox


type alias ViewOptions msg =
    { text : String
    , isRequired : Bool
    , checkboxAttrs : List (H.Attribute msg)
    }


view : ViewOptions msg -> List (H.Attribute msg) -> H.Html msg
view { text, isRequired, checkboxAttrs } attrs =
    Generic.view
        { element = H.label
        , preAttrs =
            [ HA.class "labelled-checkbox"
            ]
        , postAttrs = []
        }
        attrs
        [ Checkbox.view checkboxAttrs
        , H.span []
            ([ H.text text
             ]
                ++ (if isRequired then
                        [ H.text "\u{00A0}"
                        , H.span [ HA.class "fg-green-600" ] [ H.text "*" ]
                        ]

                    else
                        []
                   )
            )
        ]
