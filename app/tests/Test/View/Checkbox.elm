module Test.View.Checkbox exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Checkbox as Checkbox


suite : Test
suite =
    describe "View.Checkbox"
        [ test "default" <|
            \_ ->
                Checkbox.view []
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "input"
                        , Sel.attribute (HA.type_ "checkbox")
                        , Sel.exactClassName "input"
                        ]
        ]
