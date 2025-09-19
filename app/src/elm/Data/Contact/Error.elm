module Data.Contact.Error exposing
    ( consentErrorToString
    , emailErrorToString
    , queryTypeErrorToString
    , textErrorToString
    )

import Data.Contact.Bool as Bool
import Data.Contact.Email as Email
import Data.Contact.QueryType as QueryType
import Data.Contact.Text as Text
import Field.Advanced as F


consentErrorToString : Bool.Error -> String
consentErrorToString =
    let
        errorMessage =
            "To submit this form, please consent to being contacted"
    in
    F.errorToString
        { onBlank = errorMessage
        , onSyntaxError = always ""
        , onValidationError = always errorMessage
        , onCustomError = always ""
        }


emailErrorToString : Email.Error -> String
emailErrorToString =
    F.errorToString
        { onBlank = requiredMessage
        , onSyntaxError = always "Please enter a valid email address"
        , onValidationError = always ""
        , onCustomError = always ""
        }


queryTypeErrorToString : QueryType.Error -> String
queryTypeErrorToString =
    F.errorToString
        { onBlank = requiredMessage
        , onSyntaxError = always ""
        , onValidationError = always "Please enter a valid query type"
        , onCustomError = always ""
        }


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
