module Pages.Features exposing (Model, Msg, Params, page)

import Css exposing (Position, backgroundColor, color, fontSize, height, int, lineHeight, px, width, zIndex)
import Html.Styled exposing (Html, div, h4, img, p, text)
import Html.Styled.Attributes exposing (css, src)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Theme as TM
import Utils.Directive as DR


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never


type Position
    = Left
    | Right
    | Center


type Size
    = Large
    | Small


type alias Cube =
    { position : Position
    , size : Size
    }


type alias Image =
    { position : Position
    , name : String
    }


type alias Section =
    { name : String
    , images : List Image
    , bgCube : Cube
    , title : String
    , content : String
    , isComming : Bool
    , isReverse : Bool
    }



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "Features"
    , body =
        [ TE.pageTitleSection "Features" ""
        , div [ css [ atBreakpoint [ ( xl, TW.mt_24 ) ] ] ]
            (List.map sectionItem dataSection)
        ]
    }


positionX : Position -> Css.Style
positionX position =
    case position of
        Left ->
            Css.batch [ TW.mr_auto, TW.ml_0 ]

        Right ->
            Css.batch [ TW.ml_auto, TW.mr_0 ]

        Center ->
            TW.mx_auto


sizeCube : Size -> Css.Style
sizeCube typeSize =
    let
        cssSize s =
            Css.batch [ height <| px s, width <| px s ]
    in
    case typeSize of
        Large ->
            Css.batch
                [ cssSize 240
                , atBreakpoint
                    [ ( sm, cssSize 512 )
                    , ( lg, cssSize 552 )
                    , ( xl, cssSize 600 )
                    ]
                ]

        Small ->
            Css.batch
                [ cssSize 240
                , atBreakpoint
                    [ ( sm, cssSize 424 )
                    , ( lg, cssSize 456 )
                    , ( xl, cssSize 448 )
                    ]
                ]


sectionItem : Section -> Html msg
sectionItem section =
    let
        image : Image -> Html msg
        image i =
            img [ src <| "/images/content/features/" ++ i.name, css [ positionX i.position ] ] []

        bgCube =
            div
                [ css
                    [ TW.absolute
                    , zIndex <| int -1
                    , TW.inset_0
                    , TW.bg_yellow_900
                    , TW.rounded_3xl
                    , backgroundColor TM.green_25
                    , TW.mx_auto
                    , sizeCube section.bgCube.size
                    , atBreakpoint
                        [ ( sm, positionX section.bgCube.position )
                        , ( sm, TW.my_auto )
                        ]
                    ]
                ]
                []

        isChatSection =
            section.name == "chat"
    in
    div
        [ css
            [ TM.contentWrap
            , TW.py_6
            , TW.relative
            , atBreakpoint [ ( lg, TW.py_24 ) ]
            ]
        ]
        [ bgCube
        , div
            [ css
                [ TW.space_y_6
                , atBreakpoint
                    [ ( sm, DR.stylesIfTrue [ TW.flex ] <| section.name == "statistic" )
                    , ( lg, TW.flex )
                    , ( lg, TW.flex_row )
                    , ( lg, TW.space_y_0 )
                    , ( lg, DR.stylesIfTrue [ TW.flex_row_reverse ] section.isReverse )
                    ]
                ]
            ]
            [ div
                [ css
                    [ TW.space_y_4
                    , atBreakpoint
                        [ ( sm, TW.w_1over2 )
                        , ( sm, DR.stylesIfTrue [ TW.w_3over4 ] isChatSection )
                        , ( sm, DR.stylesIfTrue [ TW.w_3over4 ] <| section.name == "card" )
                        , ( sm, DR.stylesIfTrue [ TW.ml_auto ] <| section.name == "card" )
                        , ( sm, DR.stylesIfTrue [ TW.w_full ] <| section.name == "stock" )
                        , ( lg, TW.mr_16 )
                        , ( lg, TW.space_y_8 )
                        , ( lg, DR.stylesIfTrue [ TW.ml_16 ] section.isReverse )
                        , ( xl, TW.mr_20 )
                        , ( xl, DR.stylesIfTrue [ TW.ml_20 ] section.isReverse )
                        ]
                    ]
                ]
                (List.map image section.images)
            , div
                [ css
                    [ TW.relative
                    , atBreakpoint
                        [ ( sm, TW.w_1over2 )
                        , ( sm, DR.stylesIfTrue [ TW.w_3over4 ] isChatSection )
                        , ( sm, DR.stylesIfTrue [ TW.ml_auto ] isChatSection )
                        , ( sm, TW.flex )
                        , ( sm, TW.items_center )
                        , ( xl, TW.mr_20 )
                        , ( xl, TW.ml_0 )
                        , ( xl, DR.stylesIfTrue [ TW.mr_0 ] section.isReverse )
                        ]
                    ]
                ]
                [ div []
                    [ div
                        [ css
                            [ TW.relative
                            , atBreakpoint
                                [ ( sm, TW.flex )
                                , ( sm, TW.items_center )
                                ]
                            ]
                        ]
                        [ p
                            [ css
                                [ TW.text_lg
                                , TW.font_bold
                                , atBreakpoint
                                    [ ( sm, TW.text_2xl )
                                    , ( lg, fontSize <| px 32 )
                                    , ( lg, lineHeight <| px 48 )
                                    ]
                                ]
                            ]
                            [ text section.title ]
                        , TE.comingSoonLabel section.isComming
                        ]
                    , p
                        [ css
                            [ TW.mt_2
                            , color TM.grey
                            , atBreakpoint
                                [ ( sm, TW.text_lg )
                                , ( sm, TW.mt_4 )
                                , ( lg, TW.mt_6 )
                                , ( lg, TW.text_2xl )
                                ]
                            ]
                        ]
                        [ text section.content ]
                    ]
                ]
            ]
        ]


dataSection : List Section
dataSection =
    [ Section
        "chat"
        [ Image Right "chat_right.png"
        , Image Left "chat_left.png"
        ]
        (Cube Center Large)
        "Get quick assistance and answers to your questions through our advanced chats"
        "The support staff will help with any question and no need for call or an email, all the conversation can be conducted through a user friendly chat feature."
        False
        False
    , Section
        "statistic"
        [ Image Left "statistic_left.png"
        , Image Right "statistic_right.png"
        ]
        (Cube Left Small)
        "Manage your money with your inflows and outflows statistics"
        "Get information about your monthly incomes and spending for better budgeting and planning."
        False
        False
    , Section
        "card"
        [ Image Right "card.png" ]
        (Cube Right Small)
        "Co-branded bank cards"
        "Use the co-branded cards of our bank-partner and get all the privileges of the bank. "
        True
        True
    , Section
        "stock"
        [ Image Left "stock_left.png"
        , Image Right "stock_right.png"
        ]
        (Cube Center Large)
        "Investments into stocks "
        "Our major focus is on “making investments into financial instruments accessible for everyone”, while also integrating social networking components into finance app."
        True
        True
    ]
