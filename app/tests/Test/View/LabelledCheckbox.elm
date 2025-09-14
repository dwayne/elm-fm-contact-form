module Test.View.LabelledCheckbox exposing (suite)

import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.LabelledCheckbox as LabelledCheckbox


suite : Test
suite =
    describe "View.LabelledCheckbox"
        [ describe "consent" <|
            let
                view isRequired =
                    LabelledCheckbox.view
                        { text = "I consent to being contacted by the team"
                        , isRequired = isRequired
                        , checkboxAttrs =
                            [ HA.id "consent"
                            , HA.checked True
                            ]
                        }
                        []
            in
            [ test "required label" <|
                \_ ->
                    view True
                        |> Query.fromHtml
                        |> Query.has
                            [ Sel.tag "label"
                            , Sel.exactClassName "labelled-checkbox"
                            , Sel.exactText "I consent to being contacted by the team"
                            , Sel.exactText "*"
                            ]
            , test "optional label" <|
                \_ ->
                    view False
                        |> Query.fromHtml
                        |> Query.hasNot
                            [ Sel.exactText "*"
                            ]
            , test "checkbox" <|
                \_ ->
                    view True
                        |> Query.fromHtml
                        |> Query.find
                            [ Sel.attribute (HA.type_ "checkbox")
                            ]
                        |> Query.has
                            [ Sel.id "consent"
                            , Sel.checked True
                            ]
            ]
        ]
