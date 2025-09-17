module View.QueryType exposing (ViewOptions, view)

import Html as H
import Html.Attributes as HA
import Lib.Function exposing (uncurry)
import Lib.View.Generic as Generic
import View.Group as Group
import View.LabelledRadio as LabelledRadio


type alias ViewOptions msg =
    { name : String
    , first : ( LabelledRadio.ViewOptions msg, List (H.Attribute msg) )
    , second : ( LabelledRadio.ViewOptions msg, List (H.Attribute msg) )
    }


view : ViewOptions msg -> H.Html msg
view { name, first, second } =
    Group.view []
        [ uncurry LabelledRadio.view <|
            Tuple.mapFirst
                (\options ->
                    { options | radioAttrs = options.radioAttrs ++ [ HA.name name ] }
                )
                first
        , uncurry LabelledRadio.view <|
            Tuple.mapFirst
                (\options ->
                    { options | radioAttrs = options.radioAttrs ++ [ HA.name name ] }
                )
                second
        ]
