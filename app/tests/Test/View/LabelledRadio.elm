module Test.View.LabelledRadio exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.LabelledRadio as LabelledRadio


suite : Test
suite =
    describe "View.LabelledRadio"
        [ describe "general enquiry" <|
            let
                view =
                    LabelledRadio.view
                        { text = "General Enquiry"
                        , radioAttrs =
                            [ HA.name "query-type"
                            , HA.checked True
                            ]
                        }
                        []
            in
            [ test "label" <|
                \_ ->
                    view
                        |> Query.fromHtml
                        |> Query.has
                            [ Sel.tag "label"
                            , Sel.exactClassName "labelled-radio"
                            , Sel.exactText "General Enquiry"
                            ]
            , test "radio" <|
                \_ ->
                    view
                        |> Query.fromHtml
                        |> Query.find
                            [ Sel.attribute (HA.type_ "radio")
                            ]
                        |> Query.has
                            [ Sel.attribute (HA.name "query-type")
                            , Sel.checked True
                            ]
            ]
        ]
