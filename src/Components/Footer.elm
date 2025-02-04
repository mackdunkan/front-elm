module Components.Footer exposing (..)

import Css exposing (Color, backgroundColor, color, int, marginTop, px, vw, width, zIndex)
import Html.Styled exposing (Attribute, Html, a, div, footer, p, styled, text)
import Html.Styled.Attributes exposing (css, href)
import Spa.Generated.Route exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Theme as TM


type alias Options =
    { currentRoute : Route
    }


view : Options -> Html msg
view options =
    footer
        [ css
            [ TW.mt_8
            , atBreakpoint
                [ ( sm, TW.mt_12 )
                , ( lg, TW.mt_20 )
                ]
            ]
        ]
        [ div
            [ css
                [ atBreakpoint
                    [ ( md, TM.contentWrap )
                    , ( md, TW.flex )
                    , ( md, TW.flex_row )
                    , ( md, TW.flex_row_reverse )
                    , ( md, TW.items_end )
                    ]
                ]
            ]
            [ infoBlock
            , div [ css [ TW.relative, TW.z_10, TW.bg_white, atBreakpoint [ ( md, TW.w_1over2 ) ], padding ] ]
                [ div [ css [ TW.space_y_11, atBreakpoint [ ( md, TW.space_y_8 ) ] ] ]
                    [ logoBlock
                    , menuBlock
                    ]
                , bgBlockSub [ css [ TW.bg_white, TW.right_0 ] ] []
                ]
            ]
        ]


padding : Css.Style
padding =
    Css.batch
        [ atBreakpoint [ ( md, TW.py_16 ), ( lg, TW.px_6 ), ( lg, TW.py_24 ), ( xl, TW.px_8 ) ]
        , TW.py_11
        , TW.px_4
        ]


bgBlockSub : List (Attribute msg) -> List (Html msg) -> Html msg
bgBlockSub =
    styled div
        [ TW.hidden
        , TW.absolute
        , TW.inset_y_0
        , TW.h_full
        , width <| vw 50
        , zIndex <| int -1
        , atBreakpoint [ ( sm, TW.block ) ]
        ]


infoBlock : Html msg
infoBlock =
    let
        phone : String
        phone =
            "+374 60 544 000"

        email : String
        email =
            "info@mepay.am"
    in
    div
        [ css
            [ atBreakpoint
                [ ( md, TW.w_1over2 )
                , ( md, TW.pl_20 )
                , ( md, TW.pb_60 )
                , ( lg, TW.pl_24 )
                , ( lg, TW.pb_40 )
                , ( xl, TW.pl_24 )
                , ( xl, TW.pb_36 )
                ]
            , TW.relative
            , backgroundColor TM.green
            , padding
            ]
        ]
        [ div
            [ css
                [ TW.relative
                , TW.z_10
                , atBreakpoint [ ( md, TW.gap_6 ), ( lg, TW.gap_12 ) ]
                , TW.grid
                , TW.gap_4
                ]
            ]
            [ TE.infoItem True "Phone number" <| a [ href <| "tel:" ++ phone ] [ text phone ]
            , TE.infoItem True "E-mail" <| a [ href <| "mailto:" ++ email ] [ text email ]
            , TE.infoItem True "Address" <| p [] [ text "53/66 Baghramyan street, Yerevan, Armenia" ]
            ]
        , bgBlockSub [ css [ backgroundColor TM.green, TW.left_0 ] ] []
        ]


logoBlock : Html msg
logoBlock =
    div [ css [ atBreakpoint [ ( md, TW.h_11 ) ], TW.h_8 ] ] [ TE.logo ]


menuBlock : Html msg
menuBlock =
    div [ css [ TW.space_y_11 ] ]
        [ footerMenu
        , copyRight
        ]


footerMenu : Html msg
footerMenu =
    div
        [ css
            [ atBreakpoint [ ( sm, TW.grid_cols_2 ), ( sm, TW.grid_flow_col ), ( sm, TW.grid_rows_6 ), ( lg, TW.grid_rows_5 ), ( xl, TW.grid_rows_3 ) ]
            , TW.grid
            , TW.grid_cols_1
            , TW.gap_4
            ]
        ]
        (List.map (TE.linkMenu TW.text_sm) TE.listAllMenu)


copyRight : Html msg
copyRight =
    div [ css [ TW.text_sm, color TM.grey ] ] [ text "2020, mePay© All right reserved" ]
