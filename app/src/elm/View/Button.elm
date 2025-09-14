module View.Button exposing
    ( Type(..)
    , ViewOptions
    , submit
    , view
    )

import Html as H
import Html.Attributes as HA


submit : Bool -> H.Html msg
submit isDisabled =
    view
        { type_ = Submit
        , text = "Submit"
        , isDisabled = isDisabled
        , attrs = []
        }


type alias ViewOptions msg =
    { type_ : Type
    , text : String
    , isDisabled : Bool
    , attrs : List (H.Attribute msg)
    }


type Type
    = Button
    | Submit


view : ViewOptions msg -> H.Html msg
view { type_, text, isDisabled, attrs } =
    H.button
        ([ HA.class "button"
         ]
            ++ attrs
            ++ [ HA.type_ <|
                    case type_ of
                        Button ->
                            "button"

                        Submit ->
                            "submit"
               , HA.disabled isDisabled
               ]
        )
        [ H.text text ]
