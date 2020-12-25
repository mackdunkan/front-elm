module Components.Header exposing (view, viewErrorHeader)

import Components.Language as Language exposing (Language(..))
import Css exposing (backgroundColor, before, borderColor, calc, color, firstChild, focus, height, hover, int, maxHeight, maxWidth, minus, num, opacity, pct, px, vw, width)
import Html.Styled exposing (Attribute, Html, a, button, div, header, li, styled, text, ul)
import Html.Styled.Attributes exposing (class, css, disabled, href, id)
import Html.Styled.Events as Event exposing (onClick)
import Spa.Generated.Route as Route exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE exposing (..)
import Theme.Icon as TI
import Theme.Theme as TM exposing (white)
import Utils.Directive as DR exposing (stylesIfTrue)


type alias Options msg =
    { currentRoute : Route
    , onToggleMenu : Bool -> msg
    , onToggleModal : Bool -> msg
    , onToggleLang : Bool -> msg
    , isOpenMenu : Bool
    , isOpenLang : Bool
    , language : Language
    , onSelectedLang : Language -> msg
    }


view : Options msg -> Html msg
view options =
    headerSection
        [ logoSection options.isOpenMenu
        , sectionMobileMenu options.isOpenMenu
        , div [ css [ TW.w_full, TW.z_50, atBreakpoint [ ( lg, TW.flex ) ] ] ]
            [ topMenu <| Language.toString options.language
            , headerActions options
            ]
        , case options.isOpenMenu of
            True ->
                buttonControlMenu options TI.close False

            False ->
                buttonControlMenu options TI.burger True
        ]


logoSection : Bool -> Html msg
logoSection isOpen =
    a
        [ css
            [ atBreakpoint
                [ ( sm, TW.h_11 )
                , ( sm, TW.block )
                ]
            , stylesIfTrue [ TW.hidden ] isOpen
            , TW.h_8
            , TW.w_full
            ]
        , href (Route.toString (Route.Lang_String__Top { lang = "en" }))
        ]
        [ TE.logo ]


headerSection : List (Html msg) -> Html msg
headerSection lh =
    header
        [ id "header"
        , class "header"
        , css
            [ TW.fixed
            , TW.bg_white
            , TW.top_0
            , TW.inset_x_0
            , TW.w_full
            , TW.py_6
            , TW.z_40
            , atBreakpoint [ ( xl, TW.py_12 ) ]
            ]
        ]
        [ div [ css [ TM.contentWrap ] ]
            [ div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.items_center )
                        , ( sm, TW.space_x_16 )
                        ]
                    , TW.relative
                    , TW.flex
                    , TW.flex_row
                    , TW.justify_between
                    ]
                ]
                lh
            ]
        ]


viewErrorHeader : Html msg
viewErrorHeader =
    headerSection [ logoSection False ]


topMenu : String -> Html msg
topMenu lang =
    div [ css [ TW.hidden, TW.flex_row, TW.space_x_6, TW.items_center, atBreakpoint [ ( lg, TW.flex ) ] ] ]
        [ linkMenu TW.text_lg <| TE.Link "Features" (Route.Lang_String__Features { lang = lang })
        , linkMenu TW.text_lg <| TE.Link "About us" (Route.Lang_String__AboutUs { lang = lang })
        , linkMenu TW.text_lg <| TE.Link "Help" (Route.Lang_String__Help { lang = lang })
        ]


buttonControlMenu : Options msg -> Html msg -> Bool -> Html msg
buttonControlMenu options icon cmd =
    div [ css [ atBreakpoint [ ( lg, TW.hidden ) ] ] ] [ TE.iconBtn [ css [ atBreakpoint [ ( sm, TW.relative ) ], stylesIfTrue [ TW.absolute, TW.right_0 ] options.isOpenMenu, TW.z_50 ], Event.onClick <| options.onToggleMenu cmd ] icon ]


sectionMobileMenu : Bool -> Html msg
sectionMobileMenu isOpen =
    let
        widthSection =
            px 422

        beforeWidth : Css.Style
        beforeWidth =
            Css.batch
                [ width <| calc (vw 100) minus widthSection
                , atBreakpoint [ ( md, width <| calc (vw 100) minus (px 464) ) ]
                ]

        cssWidth : Css.Style
        cssWidth =
            Css.batch
                [ width <| pct 100
                , atBreakpoint [ ( sm, width widthSection ), ( md, width <| px 464 ) ]
                ]
    in
    div
        [ css
            [ TW.hidden
            , stylesIfTrue [ TW.block ] isOpen
            , TW.fixed
            , TW.inset_y_0
            , TW.right_0
            , TW.bg_white
            , TW.h_screen
            , TW.w_screen
            , TW.z_40
            , TW.py_6
            , TW.px_4
            , cssWidth
            , TW.overflow_y_auto
            , atBreakpoint [ ( sm, TW.right_0 ), ( sm, TW.left_auto ), ( md, TW.pl_6 ), ( lg, TW.hidden ) ]
            , before
                [ TW.fixed
                , Css.property "content" "''"
                , TW.inset_y_0
                , TW.left_0
                , TW.bg_black
                , TW.bg_opacity_75
                , Css.property "backdrop-filter" "blur(2px)"
                , TW.h_screen
                , beforeWidth
                ]
            ]
        ]
        [ div
            [ css
                [ atBreakpoint [ ( sm, TW.mt_24 ) ]
                , TW.flex
                , TW.flex_col
                , TW.mt_44
                ]
            ]
            [ mobileMenu ]
        ]


mobileMenu : Html msg
mobileMenu =
    div
        [ css
            [ TW.flex
            , TW.flex_col
            , TW.space_y_6
            ]
        ]
        (List.map (linkMenu TW.text_lg) listAllMenu)


headerActions : Options msg -> Html msg
headerActions options =
    div
        [ css
            [ atBreakpoint
                [ ( sm, TW.flex_row )
                , ( sm, TW.space_y_0 )
                , ( sm, TW.flex )
                , ( sm, TW.justify_end )
                , ( sm, TW.items_center )
                , ( sm, TW.space_x_24 )
                , ( md, TW.space_x_32 )
                , ( lg, TW.flex_row_reverse )
                ]
            , TW.hidden
            , DR.stylesIfTrue [ TW.flex ] options.isOpenMenu
            , TW.flex_col
            , TW.items_start
            , TW.w_full
            , TW.space_y_12
            ]
        ]
        [ div
            [ css
                [ TW.relative
                , atBreakpoint
                    [ ( sm, TW.hidden )
                    , ( sm, stylesIfTrue [ TW.block ] options.isOpenMenu )
                    , ( lg, TW.block )
                    , ( lg, TW.ml_24 )
                    ]
                ]
            ]
            [ TE.dropBtn [ disabled False, Event.onClick <| options.onToggleLang <| not options.isOpenLang ] <| Language.toString options.language
            , langMenu options
            ]
        , buttonOpenModalSubscribe options
        ]


langMenu : Options msg -> Html msg
langMenu options =
    let
        btnStyl =
            Css.batch
                [ TW.w_full
                , TW.text_left
                , TW.py_2
                , TW.px_4
                , TW.text_lg
                , focus [ TW.outline_none ]
                ]

        itemLi : Bool -> Language -> Html msg
        itemLi bool val =
            case bool of
                True ->
                    li [ css [ btnStyl, color TM.green ] ] [ text <| Language.toString options.language ]

                False ->
                    li []
                        [ button
                            [ css
                                [ btnStyl, hover [ backgroundColor TM.grey_300 ] ]
                            , Event.onClick <| options.onSelectedLang val
                            ]
                            [ text <| Language.toString val ]
                        ]
    in
    div
        [ css
            [ TW.absolute
            , TW.left_0
            , TW.mt_2
            , TW.w_56
            , TW.rounded_md
            , TM.shadow16
            , TW.z_10
            , TW.hidden
            , DR.stylesIfTrue [ TW.block ] options.isOpenLang
            , atBreakpoint
                [ ( lg, TW.right_0 )
                , ( lg, TW.left_auto )
                ]
            ]
        ]
        [ div
            [ class "scrollbar-y"
            , css
                [ TW.rounded_md
                , TW.bg_white
                , TW.space_y_2
                , TW.overflow_hidden
                , maxHeight <| px 240
                , TW.overflow_y_auto
                ]
            ]
            [ ul [ css [] ]
                [ itemLi True EN
                , itemLi False HY
                ]
            ]
        ]


buttonOpenModalSubscribe : Options msg -> Html msg
buttonOpenModalSubscribe options =
    button
        [ css
            [ TM.btnMedium
            , TW.w_full
            , TM.shadowBtn
            , atBreakpoint [ ( sm, TW.w_auto ), ( sm, TW.shadow_none ) ]
            ]
        , Event.onClick <| options.onToggleModal True
        ]
        [ text "Subscribe" ]
