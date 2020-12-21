module Pages.Lang_String.OurTariffs exposing (Model, Msg, Params, page)

import Css exposing (color)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, sm)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Theme as TM


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
    { title = "OurTariffs"
    , body =
        [ TE.pageTitleSection "Our Tariffs" ""
        , div
            [ css
                [ atBreakpoint
                    [ ( sm, TW.space_y_8 )
                    , ( lg, TW.space_y_12 )
                    ]
                , TW.space_y_6
                ]
            ]
            (List.map section dataSections)
        ]
    }


type alias Section =
    { title : String
    , items : List Item
    }


dataSections : List Section
dataSections =
    [ Section "Payments"
        [ Item "Mobile  phone top-up" "Operators:" "Beeline, VivaCell-MTS, UCOM"
        , Item "" "Commission:" "0%"
        ]
    , Section "Transfers"
        [ Item "Within the system to other account" "Commission:" "0%"
        , Item "To our cash out points" "Commission:" "0.5%"
        , Item "To local bank accounts" "Commission:" "0.5%"
        ]
    , Section "Wallet top up"
        [ Item "From our branch and terminals" "Commission:" "0%"
        , Item "From banks via cash" "Commission:" "0%"
        , Item "From banks via transfer" "Commission:" "Depending on bank fees"
        ]
    ]


section : Section -> Html msg
section s =
    div [ css [ TM.contentWrap ] ]
        [ div
            [ css
                [ TW.text_lg
                , TW.font_bold
                , TW.mb_4
                , atBreakpoint [ ( sm, TW.text_2xl ) ]
                ]
            ]
            [ text s.title ]
        , div
            [ css
                [ TW.grid
                , TW.gap_2
                , atBreakpoint
                    [ ( sm, TW.grid_cols_2 )
                    , ( sm, TW.items_end )
                    , ( sm, TW.gap_4 )
                    ]
                ]
            ]
            (List.map item s.items)
        ]


type alias Item =
    { title : String
    , head : String
    , val : String
    }


item : Item -> Html msg
item i =
    div []
        [ div
            [ css
                [ TW.text_sm
                , TW.mb_2
                , atBreakpoint
                    [ ( sm, TW.text_lg )
                    , ( sm, TW.mb_4 )
                    ]
                ]
            ]
            [ text i.title ]
        , div
            [ css
                [ TW.text_xs
                , TW.mb_1
                , color TM.grey
                , atBreakpoint
                    [ ( sm, TW.text_sm )
                    , ( sm, TW.mb_2 )
                    ]
                ]
            ]
            [ text i.head ]
        , div
            [ css
                [ TW.text_sm
                , TW.font_bold
                , atBreakpoint
                    [ ( sm, TW.text_lg )
                    ]
                ]
            ]
            [ text i.val ]
        ]
