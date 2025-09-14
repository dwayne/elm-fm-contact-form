module View.Button exposing
    ( Type(..)
    , ViewOptions
    , submit
    , view
    )

import Html as H
import Html.Attributes as HA
import Lib.View.Generic as Generic


submit : List (H.Attribute msg) -> H.Html msg
submit =
    view
        { type_ = Submit
        , text = "Submit"
        }


type alias ViewOptions =
    { type_ : Type
    , text : String
    }


type Type
    = Button
    | Submit


view : ViewOptions -> List (H.Attribute msg) -> H.Html msg
view { type_, text } attrs =
    Generic.view
        { element = H.button
        , preAttrs =
            [ HA.class "button"
            ]
        , postAttrs =
            [ HA.type_ <|
                case type_ of
                    Button ->
                        "button"

                    Submit ->
                        "submit"
            ]
        }
        attrs
        [ H.text text ]
