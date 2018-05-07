module Main exposing (..)

import Html exposing (Html, button, text, div, h1, h2, img, input, label, li, ul)
import Html.Attributes exposing (src, type_)
import Html.Events exposing (onInput, onSubmit)
import Http
import People exposing (people, peopleDisplay)


---- MODEL ----


type alias Model =
    { jobDesc : String
    , response : Maybe String
    }


initialModel : Model
initialModel =
    { jobDesc = ""
    , response = Nothing
    }


type Msg
    = NoOp
    | SubmitForm
    | SetJobDesc String
    | Response (Result Http.Error String)


type FormField
    = JobDesc



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        NoOp ->
            ( model, Cmd.none )

        SubmitForm ->
            ( { model | response = Nothing }
            , Http.send Response (postRequest model)
            )

        SetJobDesc jobDesc ->
            ( { model | jobDesc = jobDesc }, Cmd.none )

        Response (Ok response) ->
            ( { model | response = Just response }, Cmd.none )

        Response (Err error) ->
            ( { model | response = Just (toString error) }, Cmd.none )


---- HELPERS ----


postRequest : Model -> Http.Request String
postRequest model =
  let
      body = formUrlencoded
                [ ( "jobDesc", model.jobDesc )
                ]
                |> Http.stringBody "application/x-www-form-urlencoded"
    in
    Http.request
        { method = "POST"
        , headers = []
        , url = "https://httpbin.org/post"
        , body = body
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }

formUrlencoded : List ( String, String ) -> String
formUrlencoded object =
    object
        |> List.map
            (\( name, value ) ->
                Http.encodeUri name
                    ++ "="
                    ++ Http.encodeUri value
            )
        |> String.join "&"


---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ img [ src "/logo.png" ] []
            , h1 [] [ text "Welcome to Time Sink" ]
            , h2 [] [ text "You got this..." ]
            , ul []
                [ li [] [ text "Add a job" ]
                , li [] [ text "Take a job" ]
                ]
            , peopleDisplay people
            ]
        , Html.form [ onSubmit SubmitForm ]
            [ label []
                [ text "What's the job?"
                , input 
                  [ type_ "text"
                  , onInput SetJobDesc
                  ] 
                  []
                ]
            , button [] [ text "Post it" ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = ( initialModel, Cmd.none)
        , update = update
        , subscriptions = always Sub.none
        }
