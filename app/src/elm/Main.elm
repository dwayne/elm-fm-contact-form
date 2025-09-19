module Main exposing (main)

import Browser as B
import Data.Contact.Form as Contact
import Data.Contact.QueryType as QueryType
import Field.Advanced as Field
import Form
import Html as H
import Html.Attributes as HA
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


init : () -> ( Model, Cmd msg )
init _ =
    ( { form = Contact.form
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = InputFirstName String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        InputFirstName s ->
            ( { model | form = Form.modify .firstName (Field.setFromString s) model.form }
            , Cmd.none
            )



-- VIEW


view : Model -> H.Html Msg
view { form } =
    let
        filledForm =
            form
                |> Form.modify .lastName (Field.setFromString "Appleseed")
                |> Form.modify .email (Field.setFromString "email@example.com")
                |> Form.modify .queryType (Field.setFromValue QueryType.General)
                |> Form.modify .message (Field.setFromString "Hello, I would like to know if you're able to build Shopify e-commerce sites. We're starting a business and we're going to use Shopify. But it would be great to work with an agency who specialises in working with it.")
                |> Form.modify .consent (Field.setFromValue True)
    in
    H.div []
        [ Form.view
            { form = filledForm
            , onFirstName = InputFirstName
            }
        ]
