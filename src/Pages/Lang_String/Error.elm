module Pages.Lang_String.Error exposing (Model, Msg, Params, page)

import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Theme.Element as TE


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never



-- VIEW


type alias Params =
    { lang : String }


view : Url Params -> Document Msg
view { params } =
    { title = "Error"
    , body =
        [ TE.notPageView <|
            TE.NotPage
                "images/404.png"
                "Something went wrong"
                "Check your internet connection and try again"
                "Reload"
        ]
    }
