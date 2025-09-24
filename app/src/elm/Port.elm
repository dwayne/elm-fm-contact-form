port module Port exposing (sendOutput)

import Data.Contact.Email as Email
import Data.Contact.Form as Contact
import Data.Contact.QueryType as QueryType
import Data.Contact.Text as Text
import Json.Encode as JE


sendOutput : Contact.Output -> Cmd msg
sendOutput =
    encodeOutput >> send


encodeOutput : Contact.Output -> JE.Value
encodeOutput { firstName, lastName, email, queryType, message } =
    JE.object
        [ ( "tag", JE.string "output" )
        , ( "value"
          , JE.object
                [ ( "firstName", JE.string (Text.toString firstName) )
                , ( "lastName", JE.string (Text.toString lastName) )
                , ( "email", JE.string (Email.toString email) )
                , ( "queryType", JE.string (QueryType.toString queryType) )
                , ( "message", JE.string (Text.toString message) )
                ]
          )
        ]


port send : JE.Value -> Cmd msg
