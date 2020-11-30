module Components.Header exposing (view)

import Css exposing (before, calc, height, maxWidth, minus, pct, px, vw, width)
import Html.Styled exposing (Attribute, Html, a, button, div, header, styled, text)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events as Event exposing (onClick)
import Spa.Generated.Route as Route exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE exposing (..)
import Theme.Icon as TI
import Theme.Theme as TM


type alias Options msg =
    { currentRoute : Route
    , onToggleMenu : Bool -> msg
    , isOpenMenu : Bool
    }


view : Options msg -> Html msg
view options =
    header [ css [ TW.relative, TW.py_6, atBreakpoint [ ( xl, TW.py_16 ) ] ] ]
        [ div [ css [ TM.contentWrap ] ]
            [ div [ css [ atBreakpoint [ ( sm, TW.items_center ), ( sm, TW.space_x_16 ) ], TW.relative, TW.flex, TW.flex_row, TW.justify_between ] ]
                [ div [ css [ atBreakpoint [ ( sm, height <| px 42 ), ( sm, TW.block ) ], stylesIfOpenMenu [ TW.hidden ] options.isOpenMenu, TW.h_8, TW.w_full ], href (Route.toString Route.Top) ] [ TE.logo ]
                , sectionMobileMenu options.isOpenMenu
                , div [ css [ TW.w_full, TW.z_50, atBreakpoint [ ( lg, TW.flex ) ] ] ]
                    [ topMenu
                    , headerActions options
                    ]
                , case options.isOpenMenu of
                    True ->
                        buttonControlMenu options TI.close False

                    False ->
                        buttonControlMenu options TI.burger True
                ]
            ]
        ]


buttonControlMenu : Options msg -> Html msg -> Bool -> Html msg
buttonControlMenu options icon cmd =
    div [ css [ atBreakpoint [ ( lg, TW.hidden ) ] ] ] [ TE.iconBtn [ css [ atBreakpoint [ ( sm, TW.relative ) ], stylesIfOpenMenu [ TW.absolute, TW.right_0 ] options.isOpenMenu, TW.z_50 ], Event.onClick <| options.onToggleMenu cmd ] icon ]


mobMenu : Html msg
mobMenu =
    div [ css [ TW.flex, TW.flex_col, TW.space_y_6 ] ]
        [ linkMenu "About us" Route.NotFound
        , linkMenu "Features" Route.NotFound
        , linkMenu "Statements" Route.NotFound
        , linkMenu "Regulations" Route.NotFound
        , linkMenu "Terms and Conditions" Route.NotFound
        , linkMenu "User Rights" Route.NotFound
        , linkMenu "Financial mediator" Route.NotFound
        , linkMenu "Our tariffs" Route.NotFound
        , linkMenu "Terminals and branches" Route.NotFound
        ]


topMenu : Html msg
topMenu =
    div [ css [ TW.hidden, TW.flex_row, TW.space_x_6, TW.items_center, atBreakpoint [ ( lg, TW.flex ) ] ] ]
        [ linkMenu "Features" Route.NotFound
        , linkMenu "About us" Route.NotFound
        , linkMenu "Help" Route.NotFound
        ]


linkMenu : String -> Route -> Html msg
linkMenu name route =
    a [ css [ TW.text_lg, TW.whitespace_nowrap ], href (Route.toString route) ] [ text name ]


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
            , stylesIfOpenMenu [ TW.block ] isOpen
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
        [ div [ css [ atBreakpoint [ ( sm, TW.mt_24 ) ], TW.flex, TW.flex_col, TW.mt_44 ] ]
            [ mobMenu ]
        ]


headerActions : Options msg -> Html msg
headerActions options =
    div
        [ css
            [ atBreakpoint [ ( sm, TW.flex_row ), ( sm, TW.space_y_0 ), ( sm, TW.flex ), ( sm, TW.justify_end ), ( sm, TW.items_center ), ( sm, TW.space_x_24 ), ( md, TW.space_x_32 ), ( lg, TW.flex_row_reverse ) ]
            , TW.bg_white
            , TW.hidden
            , stylesIfOpenMenu [ TW.flex ] options.isOpenMenu
            , TW.flex_col
            , TW.items_start
            , TW.w_full
            , TW.space_y_12
            ]
        ]
        [ div [ css [ atBreakpoint [ ( sm, TW.hidden ), ( sm, stylesIfOpenMenu [ TW.block ] options.isOpenMenu ), ( lg, TW.block ), ( lg, TW.ml_24 ) ] ] ]
            [ TE.dropBtn [] "ENG"
            ]
        , buttonOpenModalSubscribe options
        ]


buttonOpenModalSubscribe : Options msg -> Html msg
buttonOpenModalSubscribe options =
    button [ css [ TM.btnMedium, TW.w_full, TM.shadowBtn, atBreakpoint [ ( sm, TW.w_auto ), ( sm, TW.shadow_none ) ] ], Event.onClick <| options.onToggleMenu False ] [ text "Subscribe" ]


stylesIfOpenMenu : List Css.Style -> Bool -> Css.Style
stylesIfOpenMenu styles isOpen =
    if isOpen then
        Css.batch styles

    else
        Css.batch []
