module Test.View.Input exposing (suite)

import Field.Advanced as F
import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Input as Input


suite : Test
suite =
    describe "View.Input"
        [ test "text" <|
            \_ ->
                Input.view
                    { type_ = Input.Text
                    , field = F.empty F.nonEmptyString
                    }
                    []
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "input"
                        , Sel.exactClassName "input"
                        , Sel.attribute (HA.type_ "text")
                        , Sel.attribute (HA.attribute "data-state" "clean")
                        , Sel.attribute (HA.attribute "data-validity" "invalid")
                        , Sel.attribute (HA.attribute "value" "")
                        ]
        , test "email" <|
            \_ ->
                Input.view
                    { type_ = Input.Email
                    , field = F.fromString F.nonEmptyString "a@b.c"
                    }
                    []
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "input"
                        , Sel.exactClassName "input"
                        , Sel.attribute (HA.type_ "email")
                        , Sel.attribute (HA.attribute "data-state" "clean")
                        , Sel.attribute (HA.attribute "data-validity" "valid")
                        , Sel.attribute (HA.attribute "value" "a@b.c")
                        ]
        , test "with attrs" <|
            \_ ->
                Input.view
                    { type_ = Input.Text
                    , field = F.empty F.nonEmptyString
                    }
                    [ HA.id "example"
                    , HA.class "more classes"
                    ]
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.id "example"
                        , Sel.exactClassName "input more classes"
                        ]
        ]
