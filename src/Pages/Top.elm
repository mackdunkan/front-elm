module Pages.Top exposing (Model, Msg, Params, page)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import TW.Utilities as TW
import Theme.Icon as TI
import Theme.Theme as TM


type alias Params =
    ()


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
    { title = "Homepage"
    , body = [ startScreen ]
    }


startScreen : Html msg
startScreen =
    div [ css [ TW.h_screen, TW.bg_white, TW.flex, TW.items_end ] ]
        [ div [ css [ TM.contentWrap, TW.py_6 ] ]
            [ div [ css [] ]
                [ h1 [] [ text "Enjoyable finance for everyone" ]
                , p [] [ text "With ever-increasing pace of changes, we constantly need emergence of new solutions which will ease our lives. Colibri is an “everything you need in one place” solution. " ]
                ]
            , div [ css [ TW.flex, TW.justify_center, TW.mt_6 ] ]
                [ a
                    [ css
                        [ TW.flex
                        , TW.items_center
                        , TW.justify_center
                        , TW.h_12
                        , TW.w_12
                        , TW.rounded_full
                        , TW.bg_white
                        , TM.shadow16
                        , TW.animate_bounce
                        ]
                    ]
                    [ TI.arrowDown
                    ]
                ]
            ]
        ]
