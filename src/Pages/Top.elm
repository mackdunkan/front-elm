module Pages.Top exposing (Model, Msg, Params, page)

import Arithmetic as AR exposing (isEven)
import Css exposing (Style, backgroundColor, backgroundImage, backgroundPosition, backgroundPosition2, backgroundSize, border3, center, color, fontSize, hover, lineHeight, maxWidth, pct, property, px, right, solid, top, url, zero)
import Css.Global exposing (descendants, media, typeSelector)
import Css.Media as Media exposing (all, dpi, minResolution)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, target)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl, xl2, xs_375)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
import Theme.Theme as TM exposing (white)
import Utils.Attr as UAttr
import Utils.Directive as DR


type alias Params =
    ()


type alias Model =
    Url Params


type alias Msg =
    Never


type alias Section =
    { image : String
    , title : String
    , desc : String
    , content : String
    , isComming : Bool
    }


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
            [ div [ css [ TM.contentWrap, TW.py_6 ] ]
                [ formSubscribe ]
            , div [ css [ TM.contentWrap ] ]
                [ storeBlock
                ]
            ]
        , div [ css [ TW.mt_14, TW.space_y_8 ] ]
            (List.indexedMap (\i x -> sectionItem i x) dataSection)
        ]
    }



-- TODO animate_bounce может привести к побочным эффектам!!!


startScreen : Html msg
startScreen =
    let
        bg : Css.Style
        bg =
            Css.batch
                [ atBreakpoint
                    [ ( sm, property "background-position" "center right -100px" )
                    , ( sm, backgroundSize <| pct 55 )
                    , ( lg, backgroundSize <| pct 45 )
                    , ( xl, property "background-position" "top 160px right -160px" )
                    ]
                , backgroundImage <| url "/images/bg_start-screen_home.png"
                , backgroundSize <| pct 125
                , Media.withMediaQuery [ "-webkit-min-device-pixel-ratio: 2", "min-resolution: 192dpi" ]
                    [ backgroundImage <| url "/images/bg_start-screen_home@2x.png" ]
                , TW.bg_no_repeat
                , property "background-position" "top 80px center"
                ]
    in
    div
        [ css
            [ TW.h_screen
            , TW.bg_white
            , TW.flex
            , TW.items_end
            , bg
            ]
        ]
        [ div [ css [ atBreakpoint [ ( sm, TW.bg_none ) ], TM.contentWrap, TW.py_6, TW.bg_gradient_to_t, TW.from_white ] ]
            [ div
                [ css
                    [ TW.grid
                    , atBreakpoint
                        [ ( sm, TW.grid_cols_8 )
                        , ( sm, TW.gap_6 )
                        , ( sm, TW.gap_x_14 )
                        , ( lg, TW.grid_cols_12 )
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
                                , ( xl, fontSize <| px 52 )
                                , ( xl2, TM.h1 )
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


storeBlock : Html msg
storeBlock =
    div
        [ css
            [ TW.flex
            , TW.justify_between
            , atBreakpoint [ ( xs_375, TW.grid ), ( xs_375, TW.grid_cols_2 ), ( xs_375, TW.gap_4 ) ]
            ]
        ]
        [ div [ css [ maxWidth <| px 248 ] ] [ TE.btnStoreAndroid ]
        , div [ css [ maxWidth <| px 248 ] ] [ TE.btnStoreApple ]
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


dataSection : List Section
dataSection =
    [ Section "support.png" "Support" "Get quick assistance and answers to your questions through our advanced chats" "The support staff will help with any question and no need for call or an email, all the conversation can be conducted through a user friendly chat feature." False
    , Section "statistics.png" "Statistics" "Manage your money with your inflows and outflows statistics" "Get information about your monthly incomes and spending for better budgeting and planning." False
    , Section "bank-card.png" "Bank Card" "Co-branded bank cards" "Use the co-branded cards of our bank-partner and get all the privileges of the bank." True
    ]


sectionItem : Int -> Section -> Html msg
sectionItem idx section =
    let
        pathImage =
            "/images/content/home-page/" ++ section.image
    in
    div [ css [ TM.contentWrap, TW.py_6 ] ]
        [ div
            [ css
                [ TW.space_y_6
                , atBreakpoint
                    [ ( sm, TW.flex )
                    , ( sm, TW.flex_row )
                    , ( sm, TW.space_y_0 )
                    , ( sm, DR.stylesIfTrue [ TW.flex_row_reverse ] (AR.isOdd idx) )
                    ]
                ]
            ]
            [ div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.w_1over2 )
                        , ( sm, TW.mr_6 )
                        , ( sm, DR.stylesIfTrue [ TW.ml_6 ] (AR.isOdd idx) )
                        , ( lg, TW.mr_16 )
                        , ( lg, DR.stylesIfTrue [ TW.ml_16 ] (AR.isOdd idx) )
                        , ( xl, TW.mr_20 )
                        , ( xl, DR.stylesIfTrue [ TW.ml_20 ] (AR.isOdd idx) )
                        ]
                    ]
                ]
                [ img ([ css [ TW.w_full ] ] ++ UAttr.retinaImg pathImage) []
                ]
            , div
                [ css
                    [ TW.relative
                    , atBreakpoint
                        [ ( sm, TW.w_1over2 )
                        , ( sm, TW.flex )
                        , ( sm, TW.items_center )
                        ]
                    ]
                ]
                [ div []
                    [ h4
                        [ css
                            [ TW.absolute
                            , TM.h4
                            , color TM.grey_300
                            , TW.neg_mt_6
                            , atBreakpoint
                                [ ( sm, TM.h3 )
                                , ( sm, TW.neg_mt_8 )
                                , ( lg, TM.h2 )
                                , ( lg, TW.neg_mt_12 )
                                , ( xl, TM.h1 )
                                , ( xl, TW.neg_mt_16 )
                                ]
                            ]
                        ]
                        [ text section.title ]
                    , div [ css [ TW.relative, atBreakpoint [ ( sm, TW.flex ), ( sm, TW.items_center ) ] ] ]
                        [ p
                            [ css
                                [ TW.text_lg
                                , TW.font_bold
                                , atBreakpoint
                                    [ ( sm, TW.text_2xl )
                                    , ( lg, fontSize <| px 32 )
                                    , ( lg, lineHeight <| px 48 )
                                    ]
                                ]
                            ]
                            [ text section.desc ]
                        , TE.comingSoonLabel section.isComming
                        ]
                    , p
                        [ css
                            [ TW.mt_2
                            , color TM.grey
                            , atBreakpoint
                                [ ( sm, TW.text_lg )
                                , ( lg, TW.text_2xl )
                                ]
                            ]
                        ]
                        [ text section.content ]
                    ]
                ]
            ]
        ]
