module Pages.TermsAndConditions exposing (Model, Msg, Params, page)

import Html.Styled exposing (div)
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
    { title = "TermsAndConditions"
    , body =
        [ TE.pageTitleSection "Terms and conditions"
        ]
    }
