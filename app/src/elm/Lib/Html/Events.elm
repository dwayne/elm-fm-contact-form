module Lib.Html.Events exposing (onChange)

import Html as H
import Html.Events as HE
import Json.Decode as JD


onChange : msg -> H.Attribute msg
onChange msg =
    HE.on "change" (JD.succeed msg)
