module View.Field exposing (ViewOptions, view)

import Field.Advanced as F exposing (Field)
import Html as H
import Html.Attributes as HA
import Lib.Field as F
import Lib.View.Generic as Generic
import View.Label as Label


type alias ViewOptions e a msg =
    { id : String
    , title : Maybe { text : String, isRequired : Bool }
    , control : String -> H.Html msg
    , field : Field e a
    , errorToString : e -> String
    }


view : ViewOptions e a msg -> List (H.Attribute msg) -> H.Html msg
view { id, title, control, field, errorToString } attrs =
    let
        labelChild =
            case title of
                Nothing ->
                    []

                Just { text, isRequired } ->
                    [ Label.view
                        { id = id
                        , title = text
                        , isRequired = isRequired
                        }
                        []
                    ]

        errorChild =
            if F.isDirty field then
                case F.firstError field of
                    Just error ->
                        [ H.div [ HA.class "field__error" ]
                            [ H.text (errorToString error)
                            ]
                        ]

                    Nothing ->
                        []

            else
                []
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
