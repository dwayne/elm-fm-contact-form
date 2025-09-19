module Data.Contact.Error exposing (textErrorToString)

import Data.Contact.Text as Text
import Field.Advanced as F


textErrorToString : Text.Error -> String
textErrorToString =
    F.errorToString
        { onBlank = requiredMessage
        , onSyntaxError = always ""
        , onValidationError = always ""
        , onCustomError =
            \error ->
                case error of
                    Text.TooShort { actual, min } ->
                        "This field must be at least " ++ String.fromInt min ++ " characters in length: " ++ String.fromInt actual

                    Text.TooLong { actual, max } ->
                        "This field must be at most " ++ String.fromInt max ++ " characters in length: " ++ String.fromInt actual
        }


requiredMessage : String
requiredMessage =
    "This field is required"
