module Test.View.Field exposing (suite)

import Expect
import Field as F
import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Field as F
import View.Input as Input


suite : Test
suite =
    describe "View.Field" <|
        let
            field =
                F.empty F.nonEmptyString

            view =
                F.view
                    { id = "first-name"
                    , title = Just { text = "First Name", isRequired = True }
                    , control =
                        \id ->
                            Input.view
                                { type_ = Input.Text
                                , field = field
                                }
                                [ HA.id id ]
                    , errorMessage =
                        field
                            |> F.firstError
                            |> Maybe.map
                                (F.errorToString
                                    { onBlank = "This field is required"
                                    , onSyntaxError = always ""
                                    , onValidationError = always ""
                                    }
                                )
                    }
                    []
        in
        [ test "first name" <|
            \_ ->
                view
                    |> Query.fromHtml
                    --
                    -- This test illustrates how to test multiple descendants
                    -- of one element using one test.
                    --
                    |> Expect.all
                        [ Query.has
                            [ Sel.tag "div"
                            , Sel.exactClassName "field"
                            ]
                        , Query.find [ Sel.exactClassName "label" ]
                            >> Query.has
                                [ Sel.attribute (HA.for "first-name")
                                , Sel.exactText "First Name"
                                , Sel.exactText "*"
                                ]
                        , Query.find [ Sel.exactClassName "input" ]
                            >> Query.has
                                [ Sel.attribute (HA.type_ "text")
                                , Sel.id "first-name"
                                , Sel.attribute (HA.attribute "data-state" "clean")
                                , Sel.attribute (HA.attribute "data-validity" "invalid")
                                , Sel.attribute (HA.value "")
                                ]
                        , Query.find [ Sel.exactClassName "field__error" ]
                            >> Query.has
                                [ Sel.exactText "This field is required"
                                ]
                        ]
        ]
