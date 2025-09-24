module Main exposing (main)

import Browser as B
import Data.Contact.Form as Contact
import Data.Contact.QueryType as QueryType exposing (QueryType)
import Field.Advanced as Field
import Form
import Html as H
import Html.Attributes as HA
import Lib.Browser.Dom as BD
import Port
import View.Form as Form
import View.Toast as Toast


main : Program () Model Msg
main =
    B.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL


type alias Model =
    { form : Contact.Form
    , maybeOutput : Maybe Contact.Output
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { form = Contact.form
      , maybeOutput = Nothing
      }
    , focusFirstName
    )



-- UPDATE


type Msg
    = FocusedFirstName
    | InputFirstName String
    | InputLastName String
    | InputEmail String
    | InputQueryType QueryType
    | InputMessage String
    | InputConsent Bool
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusedFirstName ->
            ( model
            , Cmd.none
            )

        InputFirstName s ->
            ( { model
                | form = Form.modify .firstName (Field.setFromString s) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        InputLastName s ->
            ( { model
                | form = Form.modify .lastName (Field.setFromString s) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        InputEmail s ->
            ( { model
                | form = Form.modify .email (Field.setFromString s) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        InputQueryType q ->
            ( { model
                | form = Form.modify .queryType (Field.setFromValue q) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        InputMessage s ->
            ( { model
                | form = Form.modify .message (Field.setFromString s) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        InputConsent b ->
            ( { model
                | form = Form.modify .consent (Field.setFromValue b) model.form
                , maybeOutput = Nothing
              }
            , Cmd.none
            )

        Submit ->
            let
                maybeOutput =
                    Form.validateAsMaybe model.form
            in
            case maybeOutput of
                Just output ->
                    ( { model | form = Contact.form, maybeOutput = maybeOutput }
                    , Cmd.batch
                        [ focusFirstName
                        , Port.sendOutput output
                        ]
                    )

                Nothing ->
                    ( model
                    , Cmd.none
                    )


focusFirstName : Cmd Msg
focusFirstName =
    BD.focus "first-name" FocusedFirstName



-- VIEW


view : Model -> H.Html Msg
view { form, maybeOutput } =
    H.div [] <|
        [ if maybeOutput == Nothing then
            H.text ""

          else
            Toast.success
        , Form.view
            { form = form
            , onFirstName = InputFirstName
            , onLastName = InputLastName
            , onEmail = InputEmail
            , onQueryType = InputQueryType
            , onMessage = InputMessage
            , onConsent = InputConsent
            , onSubmit = Submit
            }
        ]
