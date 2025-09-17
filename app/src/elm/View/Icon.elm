module View.Icon exposing (Type(..), check, view)

import Html as H
import Html.Attributes as HA


check : H.Html msg
check =
    view Check


type Type
    = Check


view : Type -> H.Html msg
view type_ =
    H.i
        [ HA.class "icon"
        , HA.attribute "data-type" <|
            case type_ of
                Check ->
                    "check"
        ]
        []
