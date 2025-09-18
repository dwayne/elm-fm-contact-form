module Main exposing (main)

import Browser as B
import Field as F
import Html as H
import Html.Attributes as HA
import View.Form as Form


main : Program () Model msg
main =
    B.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Cmd msg )
init _ =
    ( {}
    , Cmd.none
    )



-- UPDATE


update : msg -> Model -> ( Model, Cmd msg )
update _ model =
    ( model
    , Cmd.none
    )



-- VIEW


view : Model -> H.Html msg
view _ =
    H.div []
        [ Form.view
            { firstName = F.empty F.nonEmptyString
            , lastName = F.empty F.nonEmptyString
            , email = F.empty F.nonEmptyString
            , message = F.empty F.nonEmptyString
            }
        ]
