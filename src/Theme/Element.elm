module Theme.Element exposing
    ( Link
    , NotPage
    , btnStoreAndroid
    , btnStoreApple
    , comingSoonLabel
    , dropBtn
    , h4_Page
    , iconBtn
    , infoItem
    , linkMenu
    , listAllMenu
    , logo
    , notPageView
    , pageTitleSection
    )

import Css exposing (animationDuration, animationIterationCount, animationName, backgroundColor, border3, bottom, color, disabled, focus, fontSize, hex, hover, int, lineHeight, maxWidth, ms, pseudoClass, px, sec, solid)
import Css.Animations exposing (keyframes, property)
import Css.Global exposing (descendants, typeSelector)
import Html.Styled exposing (Attribute, Html, a, button, div, h1, h2, h4, img, p, span, styled, text)
import Html.Styled.Attributes exposing (attribute, css, href, src, target)
import Spa.Generated.Route as Router exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, lg, sm, xl, xs_375)
import TW.Utilities as TW
import Theme.Icon as TI
import Theme.Theme as TM
import Utils.Attr as UAttr
import Utils.Directive as DR


type alias Link =
    { label : String
    , route : Route
    }


h4_Page : String -> Html msg
h4_Page title =
    h2
        [ css
            [ TW.text_2xl
            , TW.font_bold
            , atBreakpoint
                [ ( sm, TM.h4 )
                , ( lg, TM.h2 )
                ]
            ]
        ]
        [ text title ]


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
    [ Link "About us" (Router.Lang_String__AboutUs { lang = "en" })
    , Link "Features" (Router.Lang_String__Features { lang = "en" })
    , Link "Statements" (Router.Lang_String__Statements { lang = "en" })
    , Link "Regulations" (Router.Lang_String__Regulation { lang = "en" })
    , Link "Terms and Conditions" (Router.Lang_String__TermsAndConditions { lang = "en" })
    , Link "User Rights" (Router.Lang_String__UserRights { lang = "en" })
    , Link "Financial mediator" (Router.Lang_String__FinancialMediator { lang = "en" })
    , Link "Our tariffs" (Router.Lang_String__OurTariffs { lang = "en" })
    , Link "Terminals and branches" (Router.Lang_String__TerminalsAndBranches { lang = "en" })
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
    , btnTitle : String
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
                    --[ img [ src page.imagePath, css [ TW.w_max ] ] []
                    [ img
                        ([ css [ TW.w_max ] ] ++ UAttr.retinaImg page.imagePath)
                        []
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
                    [ href <| Router.toString (Router.Lang_String__Top { lang = "en" })
                    , css
                        [ TW.mt_6
                        , TM.btnMedium
                        , TW.w_full
                        , atBreakpoint [ ( sm, TW.w_auto ) ]
                        ]
                    ]
                    [ text page.btnTitle ]
                ]
            ]
        ]


guardiansWithShortNames guardians =
    guardians
        |> List.map String.length
        |> List.filter (\x -> x < 6)
        |> List.length


pageTitleSection : String -> String -> Html msg
pageTitleSection title desc =
    let
        count_chars =
            List.length <| String.toList title
    in
    div
        [ css
            [ TW.relative
            , TW.pt_32
            , TW.pb_20
            , TW.mb_12
            , backgroundColor TM.green_25
            , TW.overflow_hidden
            , atBreakpoint
                [ ( sm, TW.pt_44 )
                , ( sm, TW.pb_36 )
                , ( lg, TW.py_44 )
                , ( xl, TW.py_60 )
                ]
            ]
        ]
        [ div [ css [ TM.contentWrap, TW.relative, TW.z_20 ] ]
            [ h1
                [ css
                    [ TM.h4
                    , DR.stylesIfTrue [ TW.text_2xl ] <| count_chars >= 18
                    , atBreakpoint
                        [ ( xs_375, TM.h4 )
                        , ( sm, TM.h3 )
                        , ( sm, TW.neg_mt_8 )
                        , ( lg, TM.h2 )
                        , ( xl, TM.h1 )
                        ]
                    ]
                ]
                [ text title ]
            , p
                [ css
                    [ DR.stylesIfTrue [ TW.hidden ] <| String.isEmpty desc
                    , TW.mt_2
                    , TW.text_sm
                    , atBreakpoint
                        [ ( sm, TW.text_lg )
                        , ( lg, TW.text_2xl )
                        , ( lg, TW.mt_8 )
                        ]
                    ]
                ]
                [ text desc ]
            ]
        , div
            [ css
                [ TW.absolute
                , TW.inset_x_0
                , bottom <| px -145
                , maxWidth <| px 2244
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


btnStore : Html msg -> String -> String -> String -> Html msg
btnStore icon title desc path =
    a
        [ href path
        , target "_blank"
        , css
            [ TW.flex
            , TW.items_center
            , TW.justify_center
            , TW.space_x_2
            , color TM.green
            , TW.px_4
            , TW.py_3_dot_5
            , border3 (px 1) solid TM.grey_300
            , TW.rounded_2xl
            , TW.bg_white
            , TW.w_full
            , hover [ backgroundColor TM.green, descendants [ typeSelector "div" [ color TM.white ] ] ]
            ]
        ]
        [ div [ css [ TW.w_4, atBreakpoint [ ( sm, TW.w_6 ) ] ] ] [ icon ]
        , div []
            [ div [ css [ TW.text_xs, TW.whitespace_nowrap ] ] [ text desc ]
            , div [ css [ TW.text_xs, TW.font_semibold, TW.whitespace_nowrap ] ] [ text title ]
            ]
        ]


btnStoreApple : Html msg
btnStoreApple =
    btnStore TI.apple "App Store" "Download on the" "https://www.apple.com/ru/app-store/"


btnStoreAndroid : Html msg
btnStoreAndroid =
    btnStore TI.android "Google Play" "Get it on" "https://www.apple.com/ru/app-store/"


comingSoonLabel : Bool -> Html msg
comingSoonLabel bool =
    case bool of
        True ->
            div
                [ css
                    [ TW.inline_block
                    , backgroundColor TM.grey
                    , TW.rounded_md
                    , TW.py_1
                    , TW.px_3
                    , TW.text_xs
                    , TW.text_white
                    , TW.whitespace_nowrap
                    , atBreakpoint [ ( sm, TW.ml_4 ) ]
                    ]
                ]
                [ text "Coming Soon" ]

        False ->
            div [] []
