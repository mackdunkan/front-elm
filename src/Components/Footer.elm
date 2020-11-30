module Components.Footer exposing (..)

import Css exposing (backgroundColor, color)
import Html.Styled exposing (Html, a, div, footer, p, text)
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
    footer []
        [ div
            [ css
                [ atBreakpoint
                    [ ( md, TM.contentWrap )
                    , ( md, TW.flex )
                    , ( md, TW.flex_row )
                    , ( md, TW.flex_row_reverse )
                    ]
                ]
            ]
            [ infoBlock
            , div [ css [ atBreakpoint [ ( md, TW.w_1over2 ), ( md, TW.space_y_8 ) ], padding, TW.space_y_11 ] ]
                [ logoBlock
                , menuBlock
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
            [ atBreakpoint [ ( md, TW.w_1over2 ), ( md, TW.pl_20 ), ( lg, TW.pl_24 ), ( xl, TW.pl_24 ) ]
            , backgroundColor TM.green
            , padding
            ]
        ]
        [ div [ css [ atBreakpoint [ ( md, TW.gap_6 ), ( lg, TW.gap_12 ) ], TW.grid, TW.gap_4 ] ]
            [ infoItem "Phone number" <| a [ href <| "tel:" ++ phone ] [ text phone ]
            , infoItem "E-mail" <| a [ href <| "mailto:" ++ email ] [ text email ]
            , infoItem "Address" <| p [] [ text "53/66 Baghramyan street, Yerevan, Armenia" ]
            ]
        ]


infoItem : String -> Html msg -> Html msg
infoItem title descHtml =
    div
        [ css
            [ TW.grid
            , TW.gap_2
            ]
        ]
        [ div [ css [ TW.text_sm, color TM.white_600 ] ]
            [ text title ]
        , div [ css [ TW.text_lg, TW.font_bold, TW.text_white ] ]
            [ descHtml ]
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
