module Lib.View.Generic exposing (ViewOptions, view)

import Html as H


type alias ViewOptions msg =
    { element : List (H.Attribute msg) -> List (H.Html msg) -> H.Html msg
    , preAttrs : List (H.Attribute msg)
    , postAttrs : List (H.Attribute msg)
    }


view : ViewOptions msg -> List (H.Attribute msg) -> List (H.Html msg) -> H.Html msg
view { element, preAttrs, postAttrs } attrs =
    element (preAttrs ++ attrs ++ postAttrs)
