module Pages.Statements exposing (Model, Msg, Params, page)

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
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "Statements"
    , body =
        [ TE.notPageView <|
            TE.NotPage
                "images/statements.png"
                "Not ready yet"
                "Company statements will be available at the start of 2022."
                "Go to main page"
        ]
    }
