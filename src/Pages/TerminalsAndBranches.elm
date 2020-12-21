module Pages.TerminalsAndBranches exposing (Model, Msg, Params, page)

import Css exposing (backgroundColor, before, borderColor, checked, color, maxWidth, px)
import Css.Global as Global exposing (adjacentSiblings, typeSelector)
import Html.Styled exposing (Html, a, div, input, label, p, span, text)
import Html.Styled.Attributes exposing (class, css, for, href, id, name, target, type_)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
import Theme.Theme as TM exposing (red, white)


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "TerminalsAndBranches"
    , body =
        [ TE.pageTitleSection "Terminals and branches" ""
        , card sectionInfo
        , card sectionFilter
        ]
    }


card : Html msg -> Html msg
card content =
    div [ class "card", css [ TW.bg_white, TW.rounded_3xl, TM.shadow24, TW.p_4, TW.grid, TW.gap_4, maxWidth <| px 328, atBreakpoint [ ( sm, TW.p_6 ) ] ] ]
        [ div [ class "card__title", css [ TW.text_sm, TW.font_bold, atBreakpoint [ ( sm, TW.text_lg ) ] ] ] [ text "Branch info" ]
        , div [ class "card__content" ]
            [ content
            ]
        ]


sectionInfo : Html msg
sectionInfo =
    let
        phone : String
        phone =
            "+374 60 544 000"

        email : String
        email =
            "info@mepay.am"

        web : String
        web =
            "www.fsm.am"
    in
    div [ css [ TW.relative, TW.z_10, atBreakpoint [ ( lg, TW.gap_6 ) ], TW.grid, TW.gap_4 ] ]
        [ infoItem "Address" <|
            div []
                [ p [] [ text "53/66 Baghramyan street, Yerevan, Armenia" ]
                ]
        , infoItem "Phone" <| a [ href <| "tel:" ++ phone ] [ text phone ]
        , infoItem "E-mail" <| a [ href <| "mailto:" ++ email ] [ text email ]
        , infoItem "Working hours:" <|
            div []
                [ p [] [ text "Mn-Fr.: 9:00-19:00" ]
                , p [] [ text "St.: 10:00-18:00" ]
                , p [] [ text "Sn.: Not worked" ]
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
        [ div [ css [ TW.text_xs, color TM.grey, atBreakpoint [ ( sm, TW.text_sm ) ] ] ]
            [ text title ]
        , div [ css [ TW.text_sm, TW.font_bold, atBreakpoint [ ( sm, TW.text_lg ) ] ] ]
            [ descHtml ]
        ]


sectionFilter : Html msg
sectionFilter =
    div [ class "sectionFilter", css [ TW.grid, TW.gap_4, atBreakpoint [ ( sm, TW.gap_6 ) ] ] ]
        [ checkLabel
        , checkLabel
        ]


checkLabel : Html msg
checkLabel =
    let
        checkbox__face =
            Css.batch
                [ TW.h_6
                , TW.w_6
                , TW.relative
                , TW.outline_none
                , TW.rounded_lg
                , before
                    [ TW.absolute
                    , Css.property "content" "''"
                    , TW.inset_0
                    , TW.w_full
                    , TW.h_full
                    , backgroundColor white
                    , TW.border
                    , borderColor TM.grey_500
                    , TW.rounded_lg
                    ]
                ]

        checkbox__input =
            Css.batch
                [ TW.hidden
                , checked
                    [ adjacentSiblings
                        [ Global.class "checkbox__face"
                            [ before
                                [ borderColor TM.green_800
                                , backgroundColor TM.green_800
                                ]
                            ]
                        ]
                    ]
                ]

        checkbox__active =
            Css.batch [ TW.relative, TW.flex, TW.h_full, TW.w_full, TW.items_center, TW.justify_center ]
    in
    label [ for "horns", class "checkbox", css [ TW.grid, TM.grid_col_auto_1fr, TW.gap_4, TW.cursor_pointer ] ]
        [ input [ class "checkbox__input", css [ checkbox__input ], id "horns", name "horns", type_ "checkbox" ] []
        , div [ class "checkbox__face", css [ checkbox__face ] ]
            [ div [ class "checkbox__active", css [ checkbox__active ] ] [ TI.check ]
            ]
        , span []
            [ text "Horns" ]
        ]
