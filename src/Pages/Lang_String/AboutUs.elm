module Pages.Lang_String.AboutUs exposing (Model, Msg, Params, page)

import Arithmetic as AR
import Css exposing (auto, backgroundColor, borderColor, calc, color, height, margin4, marginTop, minHeight, minus, pct, plus, px, width)
import Html.Styled exposing (Html, br, div, img, li, p, text, ul)
import Html.Styled.Attributes exposing (css, src)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, sm)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Theme as TM
import Utils.Attr as UAttr
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


type alias RoadItem =
    { status : Bool
    , year : Int
    , tasks : List String
    }



-- VIEW


type alias Params =
    { lang : String }


view : Url Params -> Document Msg
view { params } =
    { title = "AboutUs"
    , body =
        [ TE.pageTitleSection
            "#LightUpYourFuture"
            "The app combines in itself various functions which are called to ease our everyday lives and turn finance into an enjoyable activity."
        , sectionStart
        , sectionRoadMap
        , sectionCareer
        ]
    }


sectionRoadMap : Html msg
sectionRoadMap =
    div [ css [ TW.my_12 ] ]
        [ div [ css [ TM.contentWrap ] ]
            [ div []
                [ TE.h4_Page "Our Roudmap"
                , div
                    [ css
                        [ TW.mt_6
                        , TW.grid
                        , TW.gap_4
                        , atBreakpoint
                            [ ( sm, TW.mt_8 )
                            , ( lg, TW.mt_16 )
                            , ( lg, TW.grid_cols_12 )
                            ]
                        ]
                    ]
                    (List.indexedMap itemRoad dataRoadMap)
                ]
            ]
        ]


itemRoad : Int -> RoadItem -> Html msg
itemRoad idx road =
    div
        [ css
            [ TW.relative
            , minHeight <| px 130
            , TW.grid
            , TM.grid_col_auto_1fr
            , TW.gap_6
            , atBreakpoint
                [ ( sm, TW.grid_flow_row_dense )
                , ( sm, TW.grid_cols_8 )
                , ( lg, TW.grid_cols_none )
                , ( lg, TM.grid_row_auto_1fr )
                , ( lg, TW.col_span_3 )
                ]
            ]
        ]
        [ div
            [ css
                [ atBreakpoint
                    [ ( sm, TW.col_span_2 )
                    , ( sm, TW.col_start_4 )
                    , ( lg, TW.col_span_1 )
                    ]
                ]
            ]
            [ itemRoad_head road.status ]
        , div
            [ css
                [ atBreakpoint
                    [ ( sm, TW.col_span_3 )
                    , ( sm, TW.col_start_1 )
                    , ( sm, DR.stylesIfTrue [ TW.col_start_6 ] (AR.isOdd idx) )
                    , ( lg, TW.col_span_1 )
                    ]
                ]
            ]
            [ itemRoad_main road ]
        ]


itemRoad_main : RoadItem -> Html msg
itemRoad_main road =
    div []
        [ p
            [ css
                [ TW.font_bold
                , TW.text_lg
                , DR.stylesIfTrue [ color TM.grey ] <| not road.status
                , atBreakpoint
                    [ ( sm, TW.text_2xl )
                    , ( lg, TM.h4 )
                    ]
                ]
            ]
            [ text <| String.fromInt road.year ]
        , ul
            [ css
                [ TW.list_disc
                , TW.ml_5
                , TW.mt_2
                , TW.space_y_2
                ]
            ]
            (List.map (liTask road.status) road.tasks)
        ]


itemRoad_head : Bool -> Html msg
itemRoad_head status =
    let
        sizeMob : ( Float, Float )
        sizeMob =
            ( 32, 8 )

        sizeSM : ( Float, Float )
        sizeSM =
            ( 40, 12 )

        widthHeight : Float -> Css.Style
        widthHeight size =
            Css.batch
                [ width <| px size
                , height <| px size
                ]
    in
    div
        [ css
            [ TW.h_full
            , TW.relative
            , TW.grid
            , TW.gap_4
            , TM.grid_row_auto_1fr
            , TW.justify_center
            , atBreakpoint
                [ ( lg, TW.h_auto )
                , ( lg, TW.justify_start )
                , ( lg, TM.grid_col_auto_1fr )
                , ( lg, TW.grid_rows_none )
                ]
            ]
        ]
        [ {--Circle --}
          div
            [ css
                [ TW.flex
                , TW.items_center
                , TW.justify_center
                , widthHeight <| Tuple.first sizeMob
                , TW.border_2
                , borderColor TM.grey_500
                , DR.stylesIfTrue [ borderColor TM.grey_300 ] <| not status
                , TW.rounded_full
                , atBreakpoint [ ( sm, widthHeight <| Tuple.first sizeSM ) ]
                ]
            ]
            [ div
                [ css
                    [ widthHeight <| Tuple.second sizeMob
                    , backgroundColor TM.grey_500
                    , DR.stylesIfTrue [ backgroundColor TM.grey_300 ] <| not status
                    , TW.rounded_full
                    , atBreakpoint [ ( sm, widthHeight <| Tuple.second sizeSM ) ]
                    ]
                ]
                []
            ]

        {--Line--}
        , div
            [ css
                [ TW.relative
                , TW.inset_0
                , width <| px 4
                , height <| pct 100
                , TW.mx_auto
                , backgroundColor TM.grey_500
                , DR.stylesIfTrue [ backgroundColor TM.grey_100 ] <| not status
                , TW.rounded_full
                , atBreakpoint
                    [ ( lg, width <| pct 100 )
                    , ( lg, height <| px 4 )
                    , ( lg, TW.my_auto )
                    ]
                ]
            ]
            []
        ]


liTask : Bool -> String -> Html msg
liTask status title =
    li
        [ css
            [ TW.text_sm
            , DR.stylesIfTrue [ color TM.grey ] <| not status
            , atBreakpoint [ ( sm, TW.text_lg ) ]
            ]
        ]
        [ text title ]


dataRoadMap : List RoadItem
dataRoadMap =
    [ RoadItem
        True
        2019
        [ "Idea development" ]
    , RoadItem
        True
        2020
        [ "Company establishment"
        , "MVP development"
        , "Licensing process"
        , "Staff collection"
        ]
    , RoadItem
        False
        2021
        [ "Market release"
        , "Co-branded cards"
        , "New payments methods"
        , "Currency exchange"
        , "Splitting the check"
        ]
    , RoadItem
        False
        2022
        [ "Advanced chats"
        , "Investments into stocks"
        , "Worldwide transfers"
        , "Users’ rewarding system"
        , "Social networking components"
        ]
    ]


sectionStart : Html msg
sectionStart =
    div [ css [ TM.contentWrap ] ]
        [ div
            [ css
                [ TW.grid
                , TW.row_auto
                , atBreakpoint
                    [ ( sm, TW.grid_cols_8 )
                    , ( lg, TW.grid_cols_12 )
                    ]
                ]
            ]
            [ div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.col_start_3 )
                        , ( sm, TW.col_end_7 )
                        , ( lg, TW.col_span_6 )
                        ]
                    ]
                ]
                [ img ([ css [ TW.max_w_full, TW.mx_auto ] ] ++ UAttr.retinaImg "/images/content/aboutUs/app.png") []
                ]
            , div
                [ css
                    [ atBreakpoint
                        [ ( sm, TW.col_span_8 )
                        , ( lg, TW.col_span_5 )
                        , ( lg, TW.col_start_8 )
                        , ( lg, TW.flex )
                        , ( lg, TW.flex_col )
                        , ( lg, TW.self_center )
                        ]
                    ]
                ]
                [ TE.h4_Page "Who we are"
                , div
                    [ css
                        [ TW.mt_4
                        , atBreakpoint [ ( sm, TW.mt_8 ) ]
                        ]
                    ]
                    [ p
                        [ css
                            [ TW.text_sm
                            , color TM.grey
                            , atBreakpoint
                                [ ( sm, TW.text_lg )
                                , ( lg, TW.text_2xl )
                                ]
                            ]
                        ]
                        [ text "With ever-increasing pace of changes, we constantly need emergence of new solutions which will ease our lives. Our app is an “everything you need in one place” solution."
                        , br [] []
                        , br [] []
                        , text "The company was established in 2020 as a payment settlement organization. The mission of the company is to bring finance closer to everyone."
                        ]
                    ]
                ]
            ]
        ]


sectionCareer : Html msg
sectionCareer =
    div [ css [ TM.contentWrap ] ]
        [ div
            []
            [ TE.h4_Page "Career"
            , div
                [ css
                    [ TW.mt_4
                    , atBreakpoint [ ( sm, TW.mt_8 ) ]
                    ]
                ]
                [ p
                    [ css
                        [ TW.text_sm
                        , color TM.grey
                        , atBreakpoint
                            [ ( sm, TW.text_lg )
                            , ( lg, TW.text_2xl )
                            ]
                        ]
                    ]
                    [ text "The company does not have open vacancies at the moment."
                    ]
                ]
            ]
        ]
