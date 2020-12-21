module Pages.Lang_String.NotFound exposing (Model, Msg, Params, page)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Router exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, sm)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Theme as TM


type alias Params =
    { lang : String }


type alias Model =
    Url Params


type alias Msg =
    Never


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }



-- VIEW


view : Url Params -> Document Msg
view { params } =
    { title = "404"
    , body =
        [ TE.notPageView <|
            TE.NotPage
                "images/404.png"
                "Page not found"
                "This page does not exist or has been deleted, please check the specified link or go to the main page"
                "Go to main page"
        ]
    }
