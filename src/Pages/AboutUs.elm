module Pages.AboutUs exposing (Model, Msg, Params, page)

import Css exposing (color)
import Html.Styled exposing (Html, br, div, img, p, text)
import Html.Styled.Attributes exposing (css, src)
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
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "AboutUs"
    , body =
        [ TE.pageTitleSection
            "#LightUpYourFuture"
            "The app combines in itself various functions which are called to ease our everyday lives and turn finance into an enjoyable activity."
        , sectionStart
        , sectionRoadMap
        ]
    }


sectionRoadMap : Html msg
sectionRoadMap =
    div [ css [ TM.contentWrap ] ]
        [ div []
            [ TE.h4_Page "Who we are"
            , div
                [ css
                    [ TW.mt_4
                    , atBreakpoint [ ( sm, TW.mt_8 ) ]
                    ]
                ]
                [ p
                    [ css
                        [ TW.text_sm
                        , color TM.grey
                        , atBreakpoint
                            [ ( sm, TW.text_lg )
                            , ( lg, TW.text_2xl )
                            ]
                        ]
                    ]
                    [ text "map"
                    ]
                ]
            ]
        ]


sectionStart : Html msg
sectionStart =
    div [ css [ TM.contentWrap ] ]
        [ div
            [ css
                [ TW.grid
                , TW.row_auto
                , atBreakpoint
                    [ ( sm, TW.grid_cols_8 )
                    , ( lg, TW.grid_cols_12 )
                    ]
                ]
            ]
            [ div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.col_start_3 )
                        , ( sm, TW.col_end_7 )
                        , ( lg, TW.col_span_6 )
                        ]
                    ]
                ]
                [ img [ css [ TW.max_w_full, TW.mx_auto ], src "/images/content/aboutUs/app.png" ] []
                ]
            , div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.col_span_8 )
                        , ( lg, TW.col_span_5 )
                        , ( lg, TW.col_start_8 )
                        , ( lg, TW.flex )
                        , ( lg, TW.flex_col )
                        , ( lg, TW.self_center )
                        ]
                    ]
                ]
                [ TE.h4_Page "Who we are"
                , div
                    [ css
                        [ TW.mt_4
                        , atBreakpoint [ ( sm, TW.mt_8 ) ]
                        ]
                    ]
                    [ p
                        [ css
                            [ TW.text_sm
                            , color TM.grey
                            , atBreakpoint
                                [ ( sm, TW.text_lg )
                                , ( lg, TW.text_2xl )
                                ]
                            ]
                        ]
                        [ text "With ever-increasing pace of changes, we constantly need emergence of new solutions which will ease our lives. Our app is an “everything you need in one place” solution."
                        , br [] []
                        , br [] []
                        , text "The company was established in 2020 as a payment settlement organization. The mission of the company is to bring finance closer to everyone."
                        ]
                    ]
                ]
            ]
        ]
