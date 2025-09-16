module Test.View.QueryType exposing (suite)

import Expect
import Html.Attributes as HA
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel
import View.LabelledRadio as LabelledRadio
import View.QueryType as QueryType


suite : Test
suite =
    describe "View.QueryType" <|
        let
            view =
                QueryType.view
                    { name = "query-type"
                    , first =
                        ( { text = "General Enquiry"
                          , radioAttrs = [ HA.checked True ]
                          }
                        , [ HA.id "general-enquiry" ]
                        )
                    , second =
                        ( { text = "Support Request"
                          , radioAttrs = []
                          }
                        , [ HA.id "support-request" ]
                        )
                    }
        in
        [ test "structure" <|
            \_ ->
                view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has
                            [ Sel.tag "div"
                            , Sel.exactClassName "group"
                            ]
                        , Query.findAll [ Sel.exactClassName "labelled-radio" ]
                            >> Query.count (Expect.equal 2)
                        , Query.find [ Sel.id "general-enquiry" ]
                            >> Query.has
                                [ Sel.exactText "General Enquiry"
                                ]
                        , Query.find [ Sel.id "general-enquiry" ]
                            >> Query.find [ Sel.tag "input" ]
                            >> Query.has [ Sel.checked True ]
                        , Query.find [ Sel.id "support-request" ]
                            >> Query.has
                                [ Sel.exactText "Support Request"
                                ]
                        , Query.find [ Sel.id "support-request" ]
                            >> Query.find [ Sel.tag "input" ]
                            >> Query.hasNot [ Sel.checked True ]
                        ]
        ]
