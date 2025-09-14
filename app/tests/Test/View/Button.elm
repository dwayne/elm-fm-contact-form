module Test.View.Button exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Button as Button


suite : Test
suite =
    describe "View.Button"
        [ test "example 1" <|
            \_ ->
                Button.view
                    { type_ = Button.Button
                    , text = "A button"
                    , isDisabled = False
                    , attrs = []
                    }
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "button"
                        , Sel.attribute (HA.type_ "button")
                        , Sel.exactClassName "button"
                        , Sel.exactText "A button"
                        , Sel.disabled False
                        ]
        , test "example 2" <|
            \_ ->
                Button.view
                    { type_ = Button.Submit
                    , text = "Submit"
                    , isDisabled = False
                    , attrs = []
                    }
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "button"
                        , Sel.attribute (HA.type_ "submit")
                        , Sel.exactClassName "button"
                        , Sel.exactText "Submit"
                        , Sel.disabled False
                        ]
        ]
