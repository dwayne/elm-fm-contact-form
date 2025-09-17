module View.Toast exposing (ViewOptions, success, view)

import Html as H
import Html.Attributes as HA
import View.Icon as Icon


success : H.Html msg
success =
    H.div [ HA.class "flex justify-content-center absolute top left right" ]
        [ H.div [ HA.class "p-300" ]
            [ view
                { title = "Message Sent!"
                , body =
                    [ H.text "Thanks for completing the form. We'll be in touch soon!"
                    ]
                }
            ]
        ]


type alias ViewOptions msg =
    { title : String
    , body : List (H.Html msg)
    }


view : ViewOptions msg -> H.Html msg
view { title, body } =
    H.div [ HA.class "toast" ]
        [ H.div [ HA.class "toast__header" ]
            [ Icon.check
            , H.span [ HA.class "toast__title" ] [ H.text title ]
            ]
        , H.div [ HA.class "toast__body" ] body
        ]
