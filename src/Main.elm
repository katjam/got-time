module Main exposing (..)

import Html exposing (Html, text, div, h1, img, li, ul)
import Html.Attributes exposing (src)

import People exposing (people, peopleDisplay)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.png" ] []
        , h1 [] [ text "Welcome to Time Sink" ]
        , ul []
            [ li [] [ text "Add a job" ]
            , li [] [ text "Take a job" ]
            ]
        , peopleDisplay people
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
