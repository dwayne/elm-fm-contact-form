module Main exposing (main)

import Browser as B
import Data.Contact.Form as Contact
import Data.Contact.QueryType as QueryType exposing (QueryType)
import Field.Advanced as Field
import Form
import Html as H
import Html.Attributes as HA
import Lib.Browser.Dom as BD
import View.Form as Form


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
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { form = Contact.form
      }
    , BD.focus "first-name" FocusedFirstName
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


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        FocusedFirstName ->
            ( model
            , Cmd.none
            )

        InputFirstName s ->
            ( { model | form = Form.modify .firstName (Field.setFromString s) model.form }
            , Cmd.none
            )

        InputLastName s ->
            ( { model | form = Form.modify .lastName (Field.setFromString s) model.form }
            , Cmd.none
            )

        InputEmail s ->
            ( { model | form = Form.modify .email (Field.setFromString s) model.form }
            , Cmd.none
            )

        InputQueryType q ->
            ( { model | form = Form.modify .queryType (Field.setFromValue q) model.form }
            , Cmd.none
            )

        InputMessage s ->
            ( { model | form = Form.modify .message (Field.setFromString s) model.form }
            , Cmd.none
            )

        InputConsent b ->
            ( { model | form = Form.modify .consent (Field.setFromValue b) model.form }
            , Cmd.none
            )

        Submit ->
            ( model
            , Cmd.none
            )



-- VIEW


view : Model -> H.Html Msg
view { form } =
    H.div []
        [ Form.view
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
