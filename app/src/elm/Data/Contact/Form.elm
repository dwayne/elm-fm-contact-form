module Data.Contact.Form exposing
    ( Accessors
    , Error(..)
    , Form
    , Output
    , State
    , form
    )

import Data.Contact.Bool as Bool
import Data.Contact.Email as Email exposing (Email)
import Data.Contact.QueryType as QueryType exposing (QueryType)
import Data.Contact.Text as Text exposing (Text)
import Field.Advanced as Field exposing (Field, Validation)
import Form exposing (Accessor)



-- FORM


type alias Form =
    Form.Form State Accessors Error Output


type alias State =
    { firstName : Field Text.Error Text
    , lastName : Field Text.Error Text
    , email : Field Email.Error Email
    , queryType : Field QueryType.Error QueryType
    , message : Field Text.Error Text
    , consent : Field Bool.Error Bool
    }


type alias Accessors =
    { firstName : Accessor State (Field Text.Error Text)
    , lastName : Accessor State (Field Text.Error Text)
    , email : Accessor State (Field Email.Error Email)
    , queryType : Accessor State (Field QueryType.Error QueryType)
    , message : Accessor State (Field Text.Error Text)
    , consent : Accessor State (Field Bool.Error Bool)
    }


type Error
    = FirstNameError Text.Error
    | LastNameError Text.Error
    | EmailError Email.Error
    | QueryTypeError QueryType.Error
    | MessageError Text.Error
    | ConsentError Bool.Error


type alias Output =
    { firstName : Text
    , lastName : Text
    , email : Email
    , queryType : QueryType
    , message : Text
    }


form : Form
form =
    Form.new
        { init = init
        , accessors = accessors
        , validate = validate
        }



-- INIT


init : State
init =
    { firstName = Field.empty (Text.fieldType { min = 1, max = 25 })
    , lastName = Field.empty (Text.fieldType { min = 1, max = 25 })
    , email = Field.empty Email.fieldType
    , queryType = Field.empty QueryType.fieldType
    , message = Field.empty (Text.fieldType { min = 1, max = 300 })
    , consent = Field.empty Field.true
    }



-- ACCESSSORS


accessors : Accessors
accessors =
    { firstName =
        { get = .firstName
        , modify = \f state -> { state | firstName = f state.firstName }
        }
    , lastName =
        { get = .lastName
        , modify = \f state -> { state | lastName = f state.lastName }
        }
    , email =
        { get = .email
        , modify = \f state -> { state | email = f state.email }
        }
    , queryType =
        { get = .queryType
        , modify = \f state -> { state | queryType = f state.queryType }
        }
    , message =
        { get = .message
        , modify = \f state -> { state | message = f state.message }
        }
    , consent =
        { get = .consent
        , modify = \f state -> { state | consent = f state.consent }
        }
    }



-- VALIDATE


validate : State -> Validation Error Output
validate state =
    always Output
        |> Field.succeed
        |> Field.applyValidation (state.consent |> Field.mapError ConsentError)
        |> Field.applyValidation (state.firstName |> Field.mapError FirstNameError)
        |> Field.applyValidation (state.lastName |> Field.mapError LastNameError)
        |> Field.applyValidation (state.email |> Field.mapError EmailError)
        |> Field.applyValidation (state.queryType |> Field.mapError QueryTypeError)
        |> Field.applyValidation (state.message |> Field.mapError MessageError)
