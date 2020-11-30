module Theme.Element exposing (dropBtn, iconBtn, logo)

import Css exposing (backgroundColor, color, disabled, focus, hover, pseudoClass)
import Html.Styled exposing (Attribute, Html, button, div, img, span, styled, text)
import Html.Styled.Attributes exposing (css, src)
import TW.Utilities as TW
import Theme.Icon as TE
import Theme.Theme as TM



styleDropBtn : List (Attribute msg) -> List (Html msg) -> Html msg
styleDropBtn =
    styled button
        [ TW.text_lg
        , TW.flex
        , TW.items_center
        , TW.space_x_1
        , TW.cursor_pointer
        , color TM.black
        , focus [TW.outline_none]
        , disabled [color TM.grey]
        ]

dropBtn: List (Attribute msg) -> String -> Html msg
dropBtn attr name =
    styleDropBtn attr [span [] [text name], TE.chevronCompactDown]


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
        , hover [backgroundColor TM.grey_500]
        , focus [TW.outline_none]
        , disabled [color TM.grey_500, hover [TW.bg_transparent]]
        ]
iconBtn : List (Attribute msg) -> Html msg -> Html msg
iconBtn attr svg =
    styleIconBtn attr [svg]


logo : Html msg
logo =
    div [ css [ TW.flex, TW.flex_row, TW.items_center, TW.h_full ] ]
        [ img [ css [ TW.max_h_full, TW.h_full ], src "/images/logo.svg" ] []
        , div [ css [ TW.font_bold, TW.text_lg ] ] [ text "mePay" ]
        ]
