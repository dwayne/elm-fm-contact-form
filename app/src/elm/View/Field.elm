module View.Field exposing (ViewOptions, view)

import Field.Advanced as F exposing (Field)
import Html as H
import Html.Attributes as HA
import Lib.Field as F
import Lib.View.Generic as Generic
import View.Label as Label


type alias ViewOptions msg =
    { id : String
    , title : String
    , isRequired : Bool
    , control : String -> H.Html msg
    , errorMessage : Maybe String
    }


view : ViewOptions msg -> List (H.Attribute msg) -> H.Html msg
view { id, title, isRequired, control, errorMessage } attrs =
    let
        labelChild =
            if String.isEmpty title then
                []

            else
                [ Label.view
                    { id = id
                    , title = title
                    , isRequired = isRequired
                    }
                    []
                ]

        errorChild =
            case errorMessage of
                Nothing ->
                    []

                Just text ->
                    [ H.div [ HA.class "field__error" ]
                        [ H.text text
                        ]
                    ]
    in
    Generic.view
        { element = H.div
        , preAttrs =
            [ HA.class "field"
            ]
        , postAttrs = []
        }
        attrs
        (labelChild ++ [ control id ] ++ errorChild)
