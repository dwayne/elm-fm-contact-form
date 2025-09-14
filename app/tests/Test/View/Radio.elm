module Test.View.Radio exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Radio as Radio


suite : Test
suite =
    describe "View.Radio"
        [ test "default" <|
            \_ ->
                Radio.view []
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "input"
                        , Sel.attribute (HA.type_ "radio")
                        , Sel.exactClassName "input"
                        ]
        ]
