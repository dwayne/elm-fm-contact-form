module Test.View.Label exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Label as Label


suite : Test
suite =
    describe "View.Label" <|
        let
            view isRequired =
                Label.view
                    { id = "first-name"
                    , title = "First Name"
                    , isRequired = isRequired
                    }
                    []
        in
        [ test "required" <|
            \_ ->
                view True
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "label"
                        , Sel.exactClassName "label"
                        , Sel.attribute (HA.for "first-name")
                        , Sel.exactText "First Name"
                        , Sel.exactText "*"
                        ]
        , test "optional" <|
            \_ ->
                view False
                    |> Query.fromHtml
                    |> Query.hasNot
                        [ Sel.exactText "*"
                        ]
        ]
