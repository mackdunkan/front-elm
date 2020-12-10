module Theme.Theme exposing (..)

import Css exposing (backgroundColor, border3, borderLeft, borderLeft3, boxShadow4, color, disabled, focus, fontFamilies, fontSize, hex, hover, lineHeight, margin, maxWidth, minWidth, padding, padding2, paddingLeft, px, qt, rgb, rgba, sansSerif, solid)
import Css.Global exposing (descendants, typeSelector)
import Html.Styled.Attributes exposing (class)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl, xl2)
import TW.Utilities as TW


{-| Color Theme.
-}
green =
    hex "6BB45D"


green_25 =
    hex "F7FBF7"


green_800 =
    hex "89C37D"


green_500 =
    hex "B5D9AE"


green_100 =
    hex "CEE6CA"


orange =
    hex "FF8E00"


grey =
    hex "8995A0"


grey_100 =
    hex "FAFAFB"


grey_700 =
    hex "ACB5BD"


grey_500 =
    hex "C4CACF"


grey_300 =
    hex "DCE1E6"


black =
    hex "071C08"


red =
    hex "FF6E41"


red_50 =
    hex "FFF1EC"


white =
    rgba 255 255 255 1


white_900 =
    rgba 255 255 255 0.9


white_600 =
    rgba 255 255 255 0.6


titlePageUI : Css.Style
titlePageUI =
    Css.batch [ padding2 (px 20) (px 40), borderLeft3 (px 10) solid green_500, TW.text_h2, TW.font_semibold ]


subTitlePageUI : Css.Style
subTitlePageUI =
    Css.batch [ TW.font_bold, color grey, TW.text_h4 ]


buttonStyle : Css.Style
buttonStyle =
    Css.batch [ TW.bg_blue_500, Css.hover [ TW.bg_blue_700 ], TW.text_white, TW.font_bold, TW.py_2, TW.px_4, TW.rounded ]


pageCss : Css.Style
pageCss =
    Css.batch
        [ TW.mt_20
        , atBreakpoint
            [ ( sm, TW.mt_24 )
            , ( lg, TW.mt_28 )
            , ( xl, TW.mt_32 )
            ]
        ]


contentWrap : Css.Style
contentWrap =
    Css.batch
        [ TW.w_full
        , TW.mx_auto
        , TW.px_4
        , atBreakpoint
            [ ( sm, maxWidth (px 640) )
            , ( md, maxWidth (px 768) )
            , ( lg, maxWidth (px 1024) )
            , ( xl, maxWidth (px 1280) )
            , ( xl2, maxWidth (px 1536) )
            ]
        ]


btn : Css.Style
btn =
    Css.batch
        [ TW.flex
        , TW.flex_row
        , TW.justify_center
        , TW.text_white
        , TW.cursor_pointer
        , TW.border_0
        , TW.rounded_xl
        , fontFamilies [ qt "Inter", .value sansSerif ]
        , backgroundColor green
        , border3 (px 2) solid green
        , hover
            [ backgroundColor green_800
            , border3 (px 2) solid green_800
            , shadow16
            ]
        , focus
            [ border3 (px 2) solid green
            , TW.outline_none
            ]
        , disabled
            [ backgroundColor grey_300
            , color grey
            , border3 (px 2) solid grey_300
            ]
        ]


btnLarge : Css.Style
btnLarge =
    Css.batch
        [ btn
        , padding2 (px 16) (px 40)
        , TW.font_bold
        , TW.text_xl
        ]


btnMedium : Css.Style
btnMedium =
    Css.batch
        [ btn
        , padding2 (px 12) (px 24)
        , TW.font_semibold
        , TW.text_lg
        ]


btnSmall : Css.Style
btnSmall =
    Css.batch
        [ btn
        , padding2 (px 10) (px 20)
        , TW.font_semibold
        , TW.text_sm
        ]


link : Css.Style
link =
    Css.batch
        [ TW.flex
        , TW.items_center
        , fontFamilies [ qt "Inter", .value sansSerif ]
        , TW.font_bold
        , TW.space_x_2
        , color green
        , TW.cursor_pointer
        , hover
            [ descendants [ typeSelector "span" [ TW.underline, Css.property "text-underline-offset" "3px" ] ]
            , color green_800
            ]
        ]


linkLarge : Css.Style
linkLarge =
    Css.batch
        [ link
        , TW.text_xl
        ]


linkMedium : Css.Style
linkMedium =
    Css.batch
        [ link
        , TW.text_lg
        ]


linkSmall : Css.Style
linkSmall =
    Css.batch
        [ link
        , TW.text_sm
        ]



-- ToDo list Shadow


shadow16 : Css.Style
shadow16 =
    Css.property "box-shadow" "0px 0px 8px rgba(7, 28, 8, 0.06), 0px 8px 16px rgba(7, 28, 8, 0.08)"


shadow24 : Css.Style
shadow24 =
    Css.property "box-shadow" "0px 2px 16px rgba(7, 28, 8, 0.06), 0px 12px 24px rgba(7, 28, 8, 0.08)"


shadow32 : Css.Style
shadow32 =
    Css.property "box-shadow" "0px 4px 24px rgba(7, 28, 8, 0.04), 0px 16px 32px rgba(7, 28, 8, 0.12)"


shadowBtn : Css.Style
shadowBtn =
    Css.property "box-shadow" "0px 0px 4px rgba(85, 143, 74, 0.04), 0px 8px 16px rgba(85, 143, 74, 0.32)"


h4 : Css.Style
h4 =
    Css.batch
        [ fontSize <| px 32
        , lineHeight <| px 48
        , TW.font_black
        ]


h3 : Css.Style
h3 =
    Css.batch
        [ fontSize <| px 48
        , lineHeight <| px 56
        , TW.font_black
        ]


h2 : Css.Style
h2 =
    Css.batch
        [ fontSize <| px 64
        , lineHeight <| px 77.5
        , TW.font_black
        ]


h1 : Css.Style
h1 =
    Css.batch
        [ fontSize <| px 96
        , lineHeight <| px 104
        , TW.font_black
        ]


grid_rows_3_auto : Css.Style
grid_rows_3_auto =
    Css.property "grid-template-rows" "repeat(3, auto)"


grid_col_auto_1fr : Css.Style
grid_col_auto_1fr =
    Css.property "grid-template-columns" "auto 1fr"


grid_row_auto_1fr : Css.Style
grid_row_auto_1fr =
    Css.property "grid-template-rows" "auto 1fr"
