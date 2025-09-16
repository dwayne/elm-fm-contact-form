module View.Textarea exposing (view)

import Field.Advanced as F exposing (Field)
import Html as H
import Html.Attributes as HA
import Lib.Field as F
import Lib.View.Generic as Generic


view : Field e a -> List (H.Attribute msg) -> H.Html msg
view field attrs =
    Generic.view
        { element = H.textarea
        , preAttrs =
            [ HA.class "textarea"
            ]
        , postAttrs =
            let
                { data } =
                    F.toAttrs field
            in
            [ data.state
            , data.validity
            ]
        }
        attrs
        [ H.text (F.toRawString field) ]
