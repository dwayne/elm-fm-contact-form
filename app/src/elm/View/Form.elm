module View.Form exposing (ViewOptions, view)

import Field exposing (Field)
import Html as H
import Html.Attributes as HA
import View.Button as Button
import View.Field as Field
import View.Group as Group
import View.Input as Input
import View.LabelledCheckbox as LabelledCheckbox
import View.QueryType as QueryType
import View.Textarea as Textarea


type alias ViewOptions =
    { firstName : Field String
    , lastName : Field String
    , email : Field String
    , message : Field String
    }


view : ViewOptions -> H.Html msg
view { firstName, lastName, email, message } =
    H.form [ HA.class "form" ]
        [ viewFormSection
            [ H.h1 [ HA.class "form__title" ] [ H.text "Contact Us" ]
            , H.div [ HA.class "form__fields" ]
                [ Group.view []
                    [ Field.view
                        { id = "first-name"
                        , title = "First Name"
                        , isRequired = True
                        , control =
                            \id ->
                                Input.view
                                    { type_ = Input.Text
                                    , field = firstName
                                    }
                                    [ HA.id id
                                    ]
                        , errorMessage = Nothing
                        }
                        []
                    , Field.view
                        { id = "last-name"
                        , title = "Last Name"
                        , isRequired = True
                        , control =
                            \id ->
                                Input.view
                                    { type_ = Input.Text
                                    , field = lastName
                                    }
                                    [ HA.id id
                                    ]
                        , errorMessage = Nothing
                        }
                        []
                    ]
                , Field.view
                    { id = "email"
                    , title = "Email Address"
                    , isRequired = True
                    , control =
                        \id ->
                            Input.view
                                { type_ = Input.Email
                                , field = email
                                }
                                [ HA.id id
                                ]
                    , errorMessage = Nothing
                    }
                    []
                , Field.view
                    { id = "query-type"
                    , title = "Query Type"
                    , isRequired = True
                    , control =
                        \_ ->
                            QueryType.view
                                { name = "query-type"
                                , first =
                                    ( { text = "General Enquiry"
                                      , radioAttrs = []
                                      }
                                    , []
                                    )
                                , second =
                                    ( { text = "Support Request"
                                      , radioAttrs = []
                                      }
                                    , []
                                    )
                                }
                    , errorMessage = Nothing
                    }
                    []
                , Field.view
                    { id = "message"
                    , title = "Message"
                    , isRequired = True
                    , control =
                        \id ->
                            Textarea.view message [ HA.id id ]
                    , errorMessage = Nothing
                    }
                    []
                ]
            ]
        , viewFormSection
            [ Field.view
                { id = "consent"
                , title = ""
                , isRequired = True
                , control =
                    \id ->
                        LabelledCheckbox.view
                            { text = "I consent to being contacted by the team"
                            , isRequired = True
                            , checkboxAttrs = [ HA.id id ]
                            }
                            []
                , errorMessage = Nothing
                }
                []
            ]
        , viewFormSection
            [ Button.submit []
            ]
        ]


viewFormSection : List (H.Html msg) -> H.Html msg
viewFormSection =
    H.div [ HA.class "form__section" ]
