module Pages.Ui.Button exposing (Model, Msg, Params, page)

import Css exposing (backgroundColor, color)
import Html.Styled exposing (Html, a, button, code, div, h1, pre, span, text)
import Html.Styled.Attributes exposing (class, css, disabled)
import Html.Styled.Events exposing (onClick)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Svg.Styled exposing (svg)
import TW.Utilities as TW
import Theme.Element as TE exposing (..)
import Theme.Icon as TI exposing (..)
import Theme.Theme as TM exposing (..)


page : Page Params Model Msg
page =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Params =
    ()


type alias Model =
    {}


init : Url Params -> Model
init { params } =
    {}



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> Model
update msg model =
    case msg of
        ReplaceMe ->
            {}



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Ui.Button"
    , body =
        [ div [ css [ TM.contentWrap ] ]
            [ div [ css [ TM.titlePageUI ] ] [ text "Button" ]
            , sectionButton
            , sectionLink
            , sectionIconAndDropButton
            ]
        ]
    }


sectionButton : Html msg
sectionButton =
    div [ css [ TW.mt_8 ] ]
        [ div [ css [ subTitlePageUI ] ] [ text "- Button states" ]
        , div [ css [ TW.flex, TW.flex_row, TW.space_x_4, TW.mt_4 ] ]
            [ div [ css [ TW.space_y_2 ] ]
                [ button [ css [ TM.btnLarge ] ] [ text "Button" ]
                , button [ css [ TM.btnLarge ], disabled True ] [ text "Button" ]
                ]
            , div [ css [ TW.space_y_2 ] ]
                [ button [ css [ TM.btnMedium ] ] [ text "Button" ]
                , button [ css [ TM.btnMedium ], disabled True ] [ text "Button" ]
                ]
            , div [ css [ TW.space_y_2 ] ]
                [ button [ css [ TM.btnSmall ] ] [ text "Button" ]
                , button [ css [ TM.btnSmall ], disabled True ] [ text "Button" ]
                ]
            ]
        ]


sectionLink : Html msg
sectionLink =
    div [ css [ TW.mt_8 ] ]
        [ div [ css [ subTitlePageUI ] ] [ text "- Link" ]
        , div [ css [ TW.flex, TW.flex_row, TW.space_x_4, TW.mt_4 ] ]
            [ div [ css [ TW.flex, TW.flex_col, TW.space_y_2 ] ]
                [ a [ css [ TM.linkLarge ] ] [ span [] [ text "Label" ], TI.arrowRight ]
                , a [ css [ TM.linkMedium ] ] [ span [] [ text "Label" ], TI.arrowRight ]
                , a [ css [ TM.linkSmall ] ] [ span [] [ text "Label" ], TI.arrowRight ]
                ]
            , div [ css [ TW.flex, TW.flex_col, TW.space_y_2 ] ]
                [ a [ css [ TM.linkLarge ] ] [ span [] [ text "Label" ] ]
                , a [ css [ TM.linkMedium ] ] [ span [] [ text "Label" ] ]
                , a [ css [ TM.linkSmall ] ] [ span [] [ text "Label" ] ]
                ]
            ]
        ]


sectionIconAndDropButton : Html msg
sectionIconAndDropButton =
    div [ css [ TW.mt_8 ] ]
        [ div [ css [ subTitlePageUI ] ] [ text "- Icon and Drop button" ]
        , div [ css [ TW.flex, TW.flex_row, TW.space_x_4, TW.mt_4 ] ]
            [ div [ css [ TW.flex, TW.flex_col, TW.space_y_2 ] ]
                [ TE.dropBtn [] "ENG"
                , TE.dropBtn [ disabled True ] "ENG"
                ]
            , div [ css [ TW.flex, TW.flex_col, TW.space_y_2 ] ]
                [ TE.iconBtn [] TI.close
                , TE.iconBtn [ disabled True ] TI.close
                ]
            , div [ css [ TW.flex, TW.flex_col, TW.space_y_2 ] ]
                [ TE.iconBtn [] TI.burger
                , TE.iconBtn [ disabled True ] TI.burger
                ]
            ]
        ]
