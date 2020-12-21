module Components.Modal exposing (view)

import Css exposing (borderColor, color, focus, hex, px, right, width)
import Html.Styled exposing (Attribute, Html, button, div, h2, input, p, span, styled, text)
import Html.Styled.Attributes exposing (class, css, form, placeholder)
import Html.Styled.Events as Event
import TW.Breakpoints exposing (atBreakpoint, lg, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
import Theme.Theme as TM


type alias Options msg =
    { onToggleModal : Bool -> msg
    , isOpenModal : Bool
    }


view : Options msg -> Html msg
view options =
    case options.isOpenModal of
        True ->
            div []
                [ div
                    [ css
                        [ TW.opacity_60
                        , TW.fixed
                        , TW.inset_0
                        , TW.z_40
                        , TW.bg_black
                        ]
                    ]
                    []
                , div
                    [ css
                        [ TW.flex
                        , TW.overflow_x_hidden
                        , TW.overflow_y_auto
                        , TW.fixed
                        , TW.inset_0
                        , TW.z_50
                        , TW.items_center
                        ]
                    ]
                    [ div
                        [ css
                            [ TW.relative
                            , TW.mx_4
                            , TM.shadow32
                            , TW.rounded_3xl
                            , TW.w_full
                            , TW.bg_white
                            , TW.p_6
                            , atBreakpoint
                                [ ( sm, TW.p_8 )
                                , ( sm, TW.mx_auto )
                                , ( sm, TW.w_2over3 )
                                , ( lg, TW.p_12 )
                                , ( xl, width <| px 752 )
                                ]
                            ]
                        ]
                        [ TE.iconBtn
                            [ Event.onClick <| options.onToggleModal False
                            , css
                                [ TW.h_3_dot_5
                                , TW.w_3_dot_5
                                , TW.absolute
                                , right <| px 24
                                , color TM.black
                                , atBreakpoint
                                    [ ( sm, right <| px 32 )
                                    , ( lg, right <| px 48 )
                                    ]
                                ]
                            ]
                            TI.close
                        , div
                            []
                            [ h2
                                [ css
                                    [ TW.text_2xl
                                    , TW.font_bold
                                    , TW.pr_3_dot_5
                                    , atBreakpoint [ ( sm, TM.h4 ) ]
                                    ]
                                ]
                                [ text "Subscribe to our news" ]
                            , p
                                [ css
                                    [ TW.mt_1
                                    , TW.text_sm
                                    , atBreakpoint [ ( lg, TW.text_lg ) ]
                                    ]
                                ]
                                [ text "Stay tuned to news and updates, subscribe to our newsletter below " ]
                            ]
                        , div
                            [ css
                                [ TW.mt_4
                                , atBreakpoint [ ( sm, TW.mt_6 ) ]
                                ]
                            ]
                            [ div
                                [ css
                                    [ TW.grid
                                    , TW.gap_4
                                    , atBreakpoint
                                        [ ( lg, TM.grid_col_1fr_auto )
                                        ]
                                    ]
                                ]
                                [ div []
                                    [ styledInput [ placeholder "Your e-mail address" ] []
                                    ]
                                , button
                                    [ css
                                        [ TM.btnMedium
                                        , TW.w_full
                                        , atBreakpoint [ ( lg, TW.w_auto ) ]
                                        ]
                                    ]
                                    [ text "Subscribe" ]
                                ]
                            ]
                        ]
                    ]
                ]

        False ->
            div [ css [ TW.hidden ] ] []


styledInput : List (Attribute msg) -> List (Html msg) -> Html msg
styledInput =
    styled input
        [ TW.border
        , borderColor TM.grey_300
        , TW.rounded_xl
        , TW.py_3_dot_5
        , TW.px_4
        , TW.text_lg
        ]
