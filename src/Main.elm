module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text, button, ul, li, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)
import Html.Events exposing (onSubmit)
import Html exposing (span)

-- todo 
-- add uuid to each task
-- add possibility to edit a task
-- add vite
-- add tailwind

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Task =
  {
    done: Bool,
    title: String
  }

-- MODEL
type alias Model =
  { 
    tasks : List Task,
    task: Task
  }


init : Model
init =
  { 
    tasks = [],
    task = Task False ""
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
      { model | task = Task False newTask }
    AddTask ->
      { task = Task False "", tasks = model.task :: model.tasks }
    DeleteTask taskToDelete ->
      { model | tasks = List.filter (\t -> t.title /= taskToDelete) model.tasks }


-- VIEW
view : Model -> Html Msg
view model =
  div []
  [
    Html.form [ style "display" "flex", onSubmit AddTask ]
      [ input [ placeholder "Add a task", value model.task.title, onInput Change ] [],
        button [type_ "submit" ] [text "Add"] 
      ]
    , ul [style "list-style" "none", style "padding-inline-start" "0"]
      (
        List.map 
          (\t -> li [] 
            [
              input [type_ "checkbox"] [],
              span [] [
                text t.title
              ],
              button [style "margin-left" ".5rem", onClick (DeleteTask t.title)] [text "Delete"]
            ]
          )
        model.tasks
      )
  ]

