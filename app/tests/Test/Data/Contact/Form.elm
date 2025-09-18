module Test.Data.Contact.Form exposing (suite)

import Data.Contact.Form as Contact
import Data.Contact.Text as Text
import Expect
import Field.Advanced as Field
import Form
import Fuzz
import Test exposing (Test, describe, fuzz, test)


suite : Test
suite =
    describe "Data.Contact.Form"
        [ test "all fields are clean and empty" <|
            \_ ->
                let
                    apply2 f g a =
                        Expect.equal True (f a && g a)
                in
                Contact.form
                    |> Form.toState
                    |> Expect.all
                        [ .firstName >> apply2 Field.isClean Field.isEmpty
                        , .lastName >> apply2 Field.isClean Field.isEmpty
                        , .email >> apply2 Field.isClean Field.isEmpty
                        , .queryType >> apply2 Field.isClean Field.isEmpty
                        , .message >> apply2 Field.isClean Field.isEmpty
                        , .consent >> apply2 Field.isClean Field.isEmpty
                        ]
        , describe "firstName"
            [ fuzz (Fuzz.intRange 0 30) "it is required and must be less than 25 characters long" <|
                \n ->
                    let
                        form =
                            Contact.form
                                |> Form.modify .firstName (Field.setFromString (String.repeat n "f"))
                    in
                    if n == 0 then
                        form
                            |> Form.get .firstName
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.blankError ])

                    else if n > 25 then
                        form
                            |> Form.get .firstName
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.customError (Text.TooLong { actual = n, max = 25 }) ])

                    else
                        form
                            |> Form.get .firstName
                            |> Field.isValid
                            |> Expect.equal True
            ]
        , describe "lastName"
            [ fuzz (Fuzz.intRange 0 30) "it is required and must be less than 25 characters long" <|
                \n ->
                    let
                        form =
                            Contact.form
                                |> Form.modify .lastName (Field.setFromString (String.repeat n "l"))
                    in
                    if n == 0 then
                        form
                            |> Form.get .lastName
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.blankError ])

                    else if n > 25 then
                        form
                            |> Form.get .lastName
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.customError (Text.TooLong { actual = n, max = 25 }) ])

                    else
                        form
                            |> Form.get .lastName
                            |> Field.isValid
                            |> Expect.equal True
            ]
        , describe "email"
            [ test "it is required" <|
                \_ ->
                    Contact.form
                        |> Form.modify .email (Field.setFromString "")
                        |> Form.get .email
                        |> Field.toResult
                        |> Expect.equal (Err [ Field.blankError ])
            , test "it must contain @" <|
                \_ ->
                    Contact.form
                        |> Form.modify .email (Field.setFromString "ab.c")
                        |> Form.get .email
                        |> Field.toResult
                        |> Expect.equal (Err [ Field.syntaxError "ab.c" ])
            ]
        , describe "queryType"
            [ test "it is required" <|
                \_ ->
                    Contact.form
                        |> Form.modify .queryType (Field.setFromString "")
                        |> Form.get .queryType
                        |> Field.toResult
                        |> Expect.equal (Err [ Field.blankError ])
            ]
        , describe "message"
            [ fuzz (Fuzz.intRange 0 150) "it is required and must be less than 100 characters long" <|
                \n ->
                    let
                        form =
                            Contact.form
                                |> Form.modify .message (Field.setFromString (String.repeat n "m"))
                    in
                    if n == 0 then
                        form
                            |> Form.get .message
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.blankError ])

                    else if n > 100 then
                        form
                            |> Form.get .message
                            |> Field.toResult
                            |> Expect.equal (Err [ Field.customError (Text.TooLong { actual = n, max = 100 }) ])

                    else
                        form
                            |> Form.get .message
                            |> Field.isValid
                            |> Expect.equal True
            ]
        , describe "consent"
            [ test "it is required" <|
                \_ ->
                    Contact.form
                        |> Form.modify .consent (Field.setFromString "")
                        |> Form.get .consent
                        |> Field.toResult
                        |> Expect.equal (Err [ Field.blankError ])
            , test "it cannot be false" <|
                \_ ->
                    Contact.form
                        |> Form.modify .consent (Field.setFromValue False)
                        |> Form.get .consent
                        |> Field.toResult
                        |> Expect.equal (Err [ Field.validationError "false" ])
            , test "it must be true" <|
                \_ ->
                    Contact.form
                        |> Form.modify .consent (Field.setFromValue True)
                        |> Form.get .consent
                        |> Field.isValid
                        |> Expect.equal True
            ]
        ]
