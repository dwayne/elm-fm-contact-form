module Test.View.Textarea exposing (suite)

import Field.Advanced as F
import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.Textarea as Textarea


suite : Test
suite =
    describe "View.Textarea"
        [ test "message" <|
            \_ ->
                Textarea.view (F.fromString F.nonEmptyString "A message.")
                    [ HA.id "message" ]
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.tag "textarea"
                        , Sel.id "message"
                        , Sel.exactClassName "textarea"
                        , Sel.attribute (HA.attribute "data-state" "clean")
                        , Sel.attribute (HA.attribute "data-validity" "valid")
                        , Sel.attribute (HA.attribute "value" "A message.")
                        ]
        ]
