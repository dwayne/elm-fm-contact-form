module Lib.Html.Attributes exposing (attrList)

import Html as H


attrList : List (H.Attribute msg) -> List ( H.Attribute msg, Bool ) -> List (H.Attribute msg)
attrList required optional =
    List.concat
        [ required
        , List.filterMap
            (\( attr, keep ) ->
                if keep then
                    Just attr

                else
                    Nothing
            )
            optional
        ]
