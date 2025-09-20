module View.Form exposing (view)

import Data.Contact.Error as Error
import Data.Contact.Form as Contact
import Data.Contact.QueryType as QueryType exposing (QueryType)
import Field.Advanced as Field exposing (Field)
import Form
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Lib.Html.Events as HE
import View.Button as Button
import View.Field as Field
import View.Group as Group
import View.Input as Input
import View.LabelledCheckbox as LabelledCheckbox
import View.QueryType as QueryType
import View.Textarea as Textarea


type alias ViewOptions msg =
    { form : Contact.Form
    , onFirstName : String -> msg
    , onLastName : String -> msg
    , onEmail : String -> msg
    , onQueryType : QueryType -> msg
    , onMessage : String -> msg
    , onConsent : Bool -> msg
    }


view : ViewOptions msg -> H.Html msg
view { form, onFirstName, onLastName, onEmail, onQueryType, onMessage, onConsent } =
    let
        { firstName, lastName, email, queryType, message, consent } =
            Form.toState form
    in
    H.form [ HA.class "form" ]
        [ viewFormSection
            [ H.h1 [ HA.class "form__title" ] [ H.text "Contact Us" ]
            , H.div [ HA.class "form__fields" ]
                [ Group.view []
                    [ Field.view
                        { id = "first-name"
                        , title = Just { text = "First Name", isRequired = True }
                        , control =
                            \id ->
                                Input.view
                                    { type_ = Input.Text
                                    , field = firstName
                                    }
                                    [ HA.id id
                                    , HE.onInput onFirstName
                                    ]
                        , field = firstName
                        , errorToString = Error.textErrorToString
                        }
                        []
                    , Field.view
                        { id = "last-name"
                        , title = Just { text = "Last Name", isRequired = True }
                        , control =
                            \id ->
                                Input.view
                                    { type_ = Input.Text
                                    , field = lastName
                                    }
                                    [ HA.id id
                                    , HE.onInput onLastName
                                    ]
                        , field = lastName
                        , errorToString = Error.textErrorToString
                        }
                        []
                    ]
                , Field.view
                    { id = "email"
                    , title = Just { text = "Email Address", isRequired = True }
                    , control =
                        \id ->
                            Input.view
                                { type_ = Input.Email
                                , field = email
                                }
                                [ HA.id id
                                , HE.onInput onEmail
                                ]
                    , field = email
                    , errorToString = Error.emailErrorToString
                    }
                    []
                , Field.view
                    { id = "query-type"
                    , title = Just { text = "Query Type", isRequired = True }
                    , control =
                        \_ ->
                            let
                                maybeValue =
                                    Field.toMaybe queryType
                            in
                            QueryType.view
                                { name = "query-type"
                                , first =
                                    ( { text = "General Enquiry"
                                      , radioAttrs =
                                            let
                                                checked =
                                                    maybeValue == Just QueryType.General
                                            in
                                            [ HA.checked checked
                                            , HE.onChange (onQueryType QueryType.General)
                                            ]
                                      }
                                    , []
                                    )
                                , second =
                                    ( { text = "Support Request"
                                      , radioAttrs =
                                            let
                                                checked =
                                                    maybeValue == Just QueryType.Support
                                            in
                                            [ HA.checked checked
                                            , HE.onChange (onQueryType QueryType.Support)
                                            ]
                                      }
                                    , []
                                    )
                                }
                    , field = queryType
                    , errorToString = Error.queryTypeErrorToString
                    }
                    []
                , Field.view
                    { id = "message"
                    , title = Just { text = "Message", isRequired = True }
                    , control =
                        \id ->
                            Textarea.view
                                message
                                [ HA.id id
                                , HE.onInput onMessage
                                ]
                    , field = message
                    , errorToString = Error.textErrorToString
                    }
                    []
                ]
            ]
        , viewFormSection
            [ Field.view
                { id = "consent"
                , title = Nothing
                , control =
                    \id ->
                        LabelledCheckbox.view
                            { text = "I consent to being contacted by the team"
                            , isRequired = True
                            , checkboxAttrs =
                                let
                                    checked =
                                        Field.toMaybe consent == Just True
                                in
                                [ HA.id id
                                , HA.checked checked
                                , HE.onChange (onConsent <| not checked)
                                ]
                            }
                            []
                , field = consent
                , errorToString = Error.consentErrorToString
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
