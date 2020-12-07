module Theme.Element exposing (Link, NotPage, dropBtn, iconBtn, infoItem, linkMenu, listAllMenu, logo, notPageView, pageTitleSection)

import Css exposing (animationDuration, animationIterationCount, animationName, backgroundColor, bottom, color, disabled, focus, fontSize, hex, hover, int, lineHeight, maxWidth, ms, pseudoClass, px, sec)
import Css.Animations exposing (keyframes, property)
import Html.Styled exposing (Attribute, Html, a, button, div, h1, h4, img, p, span, styled, text)
import Html.Styled.Attributes exposing (css, href, src)
import Spa.Generated.Route as Router exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, lg, sm, xl)
import TW.Utilities as TW
import Theme.Icon as TI
import Theme.Theme as TM


type alias Link =
    { label : String
    , route : Route
    }


styleDropBtn : List (Attribute msg) -> List (Html msg) -> Html msg
styleDropBtn =
    styled button
        [ TW.text_lg
        , TW.flex
        , TW.items_center
        , TW.space_x_1
        , TW.cursor_pointer
        , color TM.black
        , focus [ TW.outline_none ]
        , disabled [ color TM.grey ]
        ]


dropBtn : List (Attribute msg) -> String -> Html msg
dropBtn attr name =
    styleDropBtn attr [ span [] [ text name ], TI.chevronCompactDown ]


styleIconBtn : List (Attribute msg) -> List (Html msg) -> Html msg
styleIconBtn =
    styled button
        [ TW.flex
        , TW.justify_center
        , TW.items_center
        , TW.h_8
        , TW.w_8
        , TW.rounded_md
        , TW.cursor_pointer
        , hover [ backgroundColor TM.grey_500 ]
        , focus [ TW.outline_none ]
        , disabled [ color TM.grey_500, hover [ TW.bg_transparent ] ]
        ]


iconBtn : List (Attribute msg) -> Html msg -> Html msg
iconBtn attr svg =
    styleIconBtn attr [ svg ]


logo : Html msg
logo =
    div [ css [ TW.flex, TW.flex_row, TW.items_center, TW.h_full ] ]
        [ img [ css [ TW.max_h_full, TW.h_full ], src "/images/logo.svg" ] []
        , div [ css [ TW.font_bold, TW.text_lg ] ] [ text "mePay" ]
        ]


listAllMenu : List Link
listAllMenu =
    [ Link "About us" Router.NotFound
    , Link "Features" Router.NotFound
    , Link "Statements" Router.Statements
    , Link "Regulations" Router.Regulation
    , Link "Terms and Conditions" Router.TermsAndConditions
    , Link "User Rights" Router.NotFound
    , Link "Financial mediator" Router.FinancialMediator
    , Link "Our tariffs" Router.OurTariffs
    , Link "Terminals and branches" Router.NotFound
    ]


linkMenu : Css.Style -> Link -> Html msg
linkMenu sizeFont link =
    a
        [ css
            [ sizeFont
            , TW.whitespace_nowrap
            , hover [ color TM.green ]
            ]
        , href (Router.toString link.route)
        ]
        [ text link.label ]


type alias NotPage =
    { imagePath : String
    , title : String
    , description : String
    }


notPageView : NotPage -> Html msg
notPageView page =
    div [ css [ TM.pageCss ] ]
        [ div
            [ css
                [ TW.px_4
                , TW.mx_auto
                , maxWidth <| px 360
                , TW.py_6
                ]
            ]
            [ div
                [ css
                    [ TW.flex
                    , TW.flex_col
                    , TW.items_center
                    , TW.justify_center
                    ]
                ]
                [ div [ css [ TW.mb_4 ] ]
                    [ img [ src page.imagePath, css [ TW.w_max ] ] []
                    ]
                , h4
                    [ css
                        [ TW.text_lg
                        , TW.font_bold
                        , TW.text_center
                        , TW.mt_2
                        ]
                    ]
                    [ text page.title ]
                , p [ css [ TW.text_center ] ] [ text page.description ]
                , a
                    [ href <| Router.toString Router.Top
                    , css
                        [ TW.mt_6
                        , TM.btnMedium
                        , TW.w_full
                        , atBreakpoint [ ( sm, TW.w_auto ) ]
                        ]
                    ]
                    [ text "Go to main page" ]
                ]
            ]
        ]


pageTitleSection : String -> Html msg
pageTitleSection title =
    div
        [ css
            [ TW.relative
            , TW.pt_32
            , TW.pb_20
            , TW.mb_12
            , backgroundColor <| hex "F7FBF7"
            , TW.overflow_hidden
            , atBreakpoint
                [ ( sm, TW.pt_44 )
                , ( sm, TW.pb_36 )
                , ( lg, TW.py_44 )
                , ( xl, TW.py_60 )
                ]
            ]
        ]
        [ div [ css [ TM.contentWrap ] ]
            [ h1
                [ css
                    [ TW.relative
                    , TM.h4
                    , TW.z_20
                    , atBreakpoint
                        [ ( sm, TM.h3 )
                        , ( sm, TW.neg_mt_8 )
                        , ( lg, TM.h2 )
                        , ( xl, TM.h1 )
                        ]
                    ]
                ]
                [ text title ]
            ]
        , div
            [ css
                [ TW.absolute
                , TW.inset_x_0
                , TW.bottom_0
                , maxWidth <| px 1920
                , TW.mx_auto
                ]
            ]
            (List.map itemLine (List.range 1 4))
        ]


itemLine : Int -> Html msg
itemLine num =
    let
        numBottom =
            (*) num -25
    in
    div
        [ css
            [ animationName (keyframes [ ( 0, [ property "width" "0%" ] ), ( 100, [ property "width" "100%" ] ) ])
            , animationDuration <| sec 3
            , animationIterationCount <| int 1
            , TW.overflow_hidden
            , TW.absolute
            , TW.left_0
            , TW.right_0
            , bottom <| px <| toFloat numBottom
            , TW.z_10
            ]
        ]
        [ TI.line ]


infoItem : Bool -> String -> Html msg -> Html msg
infoItem themeWhite title descHtml =
    let
        theme =
            case themeWhite of
                True ->
                    ( color TM.white_600, TW.text_white )

                False ->
                    ( color TM.grey, color TM.black )
    in
    div
        [ css
            [ TW.grid
            , TW.gap_2
            ]
        ]
        [ div [ css [ TW.text_sm, Tuple.first theme ] ]
            [ text title ]
        , div [ css [ TW.text_lg, TW.font_bold, Tuple.second theme ] ]
            [ descHtml ]
        ]
