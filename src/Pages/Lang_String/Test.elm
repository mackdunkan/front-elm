module Pages.Lang_String.Test exposing (Model, Msg, Params, page)

import Css exposing (padding2, px)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Params =
    { lang : String }


type alias Model =
    { test : Int }


init : Url Params -> Model
init { params } =
    { test = 0 }



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> Model
update msg model =
    case msg of
        ReplaceMe ->
            { model | test = 1 }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Test"
    , body = [ section ]
    }


section : Html Msg
section =
    div [ onClick ReplaceMe, css [ padding2 (px 200) (px 100) ] ] [ text "Click Test" ]
