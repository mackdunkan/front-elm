module Pages.AboutUs exposing (Model, Msg, Params, page)

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
    { title = "AboutUs"
    , body = [ TE.pageTitleSection "#LightUpYourFuture" "The app combines in itself various functions which are called to ease our everyday lives and turn finance into an enjoyable activity." ]
    }
