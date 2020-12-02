module Pages.Top exposing (Model, Msg, Params, page)

import Css exposing (Style, backgroundImage, backgroundPosition, backgroundPosition2, border3, center, color, fontSize, maxWidth, property, px, right, solid, top, url, zero)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, target)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl, xl2, xs_375)
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
    , body =
        [ startScreen
        , div [ css [ atBreakpoint [ ( sm, TW.hidden ) ] ] ]
            [ div [ css [ TW.bg_white, TM.contentWrap, TW.py_6 ] ]
                [ formSubscribe ]
            , div [ css [ TW.bg_white, TM.contentWrap ] ]
                [ storeBlock
                ]
            ]
        ]
    }



-- TODO animate_bounce может привести к побочным эффектам!!!


startScreen : Html msg
startScreen =
    let
        bg : Css.Style
        bg =
            Css.batch
                [ backgroundImage <| url "/images/bg_start-screen_home__460.png"
                , TW.bg_no_repeat
                , property "background-position" "top 80px center"
                , atBreakpoint [ ( sm, property "background-position" "center right -100px" ) ]
                ]
    in
    div [ css [ TW.h_screen, TW.bg_white, TW.flex, TW.items_end, bg ] ]
        [ div [ css [ TM.contentWrap, TW.py_6, TW.bg_gradient_to_t, TW.from_white ] ]
            [ div
                [ css
                    [ TW.grid
                    , atBreakpoint
                        [ ( sm, TW.grid_cols_8 )
                        , ( sm, TW.gap_6 )
                        , ( lg, TW.grid_cols_12 )
                        , ( sm, TW.gap_x_14 )
                        , ( lg, TW.grid_flow_col )
                        , ( lg, TM.grid_rows_3_auto )
                        , ( lg, TW.gap_y_8 )
                        , ( xl, TW.gap_x_8 )
                        , ( xl, TW.gap_y_12 )
                        ]
                    ]
                ]
                [ div
                    [ css
                        [ atBreakpoint
                            [ ( sm, TW.col_span_6 )
                            , ( sm, TW.space_y_6 )
                            , ( md, TW.col_span_5 )
                            , ( lg, TW.col_span_8 )
                            , ( xl, TW.space_y_12 )
                            , ( xl2, TW.col_span_7 )
                            ]
                        , TW.space_y_2
                        ]
                    ]
                    [ h1
                        [ css
                            [ TM.h4
                            , atBreakpoint
                                [ ( sm, TM.h3 )
                                , ( lg, TM.h2 )
                                , ( lg, fontSize <| px 40 )
                                , ( xl, TM.h1 )
                                ]
                            ]
                        ]
                        [ text "Enjoyable finance for everyone" ]
                    , p
                        [ css
                            [ TW.text_sm
                            , color TM.grey
                            , TW.leading_6
                            , atBreakpoint
                                [ ( sm, TW.text_lg )
                                , ( lg, TW.text_2xl )
                                ]
                            ]
                        ]
                        [ text "With ever-increasing pace of changes, we constantly need emergence of new solutions which will ease our lives. Colibri is an “everything you need in one place” solution. " ]
                    ]
                , div [ css [ atBreakpoint [ ( sm, TW.block ), ( lg, TW.col_span_6 ) ], TW.hidden, TW.col_span_5 ] ]
                    [ formSubscribe
                    ]
                , div [ css [ atBreakpoint [ ( sm, TW.block ), ( lg, TW.col_span_5 ), ( xl, TW.col_span_4 ) ], TW.hidden, TW.col_span_6 ] ]
                    [ storeBlock
                    ]
                ]
            , btnScroll
            ]
        ]


btnScroll : Html msg
btnScroll =
    div [ css [ TW.flex, TW.justify_center, TW.mt_6 ] ]
        [ div []
            [ div [ css [ TW.hidden, TW.mb_4, TW.text_center, atBreakpoint [ ( sm, TW.block ) ] ] ] [ text "Scroll" ]
            , div
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


formSubscribe =
    let
        styleInput : Css.Style
        styleInput =
            Css.batch
                [ TW.px_4
                , TW.py_3
                , TW.text_lg
                , TW.leading_8
                , TM.shadow24
                , TW.rounded_2xl
                , atBreakpoint [ ( sm, TW.py_5 ) ]
                ]
    in
    form []
        [ div
            [ css
                [ atBreakpoint [ ( sm, TW.space_y_0 ) ]
                , TW.space_y_4
                , TW.relative
                ]
            ]
            [ input [ css [ styleInput ], placeholder "Your e-mail address" ] []
            , button
                [ css
                    [ TM.btnMedium
                    , TW.w_full
                    , TM.shadowBtn
                    , atBreakpoint
                        [ ( sm, TW.w_auto )
                        , ( sm, TW.absolute )
                        , ( sm, TW.inset_y_2 )
                        , ( sm, TW.right_2 )
                        ]
                    ]
                ]
                [ text "Subscribe" ]
            ]
        ]


storeBlock : Html msg
storeBlock =
    div
        [ css
            [ TW.flex
            , TW.justify_between
            , atBreakpoint [ ( xs_375, TW.grid ), ( xs_375, TW.grid_cols_2 ), ( xs_375, TW.gap_4 ) ]
            ]
        ]
        [ btnStore TI.apple "App Store" "Download on the" "https://www.apple.com/ru/app-store/"
        , btnStore TI.android "Google Play" "Get it on" "https://www.apple.com/ru/app-store/"
        ]


btnStore : Html msg -> String -> String -> String -> Html msg
btnStore icon title desc path =
    a
        [ href path
        , target "_blank"
        , css
            [ atBreakpoint [ ( lg, maxWidth <| px 248 ) ]
            , TW.flex
            , TW.items_center
            , TW.justify_center
            , TW.space_x_2
            , color TM.green
            , TW.px_4
            , TW.py_3_dot_5
            , border3 (px 1) solid TM.grey_300
            , TW.rounded_2xl
            , TW.bg_white
            , maxWidth <| px 248
            ]
        ]
        [ div [ css [ TW.w_4, atBreakpoint [ ( sm, TW.w_6 ) ] ] ] [ icon ]
        , div []
            [ div [ css [ TW.text_xs, TW.whitespace_nowrap ] ] [ text desc ]
            , div [ css [ TW.text_xs, TW.font_semibold, TW.whitespace_nowrap ] ] [ text title ]
            ]
        ]



--section: String -> Html msg
--section image =
--    div []
