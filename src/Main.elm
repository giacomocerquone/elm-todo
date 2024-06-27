module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text, button, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)
import Html.Events exposing (onSubmit)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { 
    tasks : List String,
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
  | DeleteTask String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newTask ->
      { model | task = newTask }
    AddTask ->
      { task = "", tasks = model.task :: model.tasks }
    DeleteTask taskToDelete ->
      { model | tasks = List.filter (\t -> t /= taskToDelete) model.tasks }


-- VIEW
view : Model -> Html Msg
view model =
  div []
  [
    Html.form [ style "display" "flex", onSubmit AddTask ]
      [ input [ placeholder "Add a task", value model.task, onInput Change ] [],
        button [type_ "submit" ] [text "Add"] 
      ]
    , ul []
      (
        List.map 
          (\t -> li [] 
            [
              text (t ++ " - "),
              button [onClick (DeleteTask t)] [text "Delete"]
            ]
          )
        model.tasks
      )
  ]

