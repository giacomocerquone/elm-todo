module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text, button, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL
type alias Model =
  { tasks : List String,
  task: String
  }


init : Model
init =
  { 
    tasks = [],
    task = "" 
  }



-- UPDATE
type Msg
  = Change String
  | AddTask

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | task = newContent }
    AddTask ->
      { task = "", tasks = model.task :: model.tasks }



-- VIEW
view : Model -> Html Msg
view model =
  div []
  [
    div [ style "display" "flex" ]
      [ input [ placeholder "Add a task", value model.task, onInput Change ] []
      , button [onClick AddTask] [ text "Add"] 
      ]
    , ul []
      (List.map (\t-> li [] [text t]) model.tasks)
  ]

