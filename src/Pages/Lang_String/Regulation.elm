module Pages.Lang_String.Regulation exposing (Model, Msg, Params, page)

import Css exposing (backgroundColor)
import Html.Styled exposing (Html, a, div, h2, p, span, text)
import Html.Styled.Attributes exposing (class, css)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
import Theme.Theme as TM


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never


type alias Item =
    { description : String
    , path : String
    }



-- VIEW


type alias Params =
    { lang : String }


view : Url Params -> Document Msg
view { params } =
    { title = "Regulation"
    , body =
        [ TE.pageTitleSection "Regulation" ""
        , div []
            [ div [ css [ TM.contentWrap ] ]
                [ div
                    [ css
                        [ TW.grid
                        , atBreakpoint
                            [ ( lg, TW.grid_cols_2 )
                            , ( lg, TW.gap_6 )
                            ]
                        ]
                    ]
                    [ item (Item "Our system rules" "#")
                    ]
                ]
            ]
        , div
            [ css
                [ TW.my_16
                , atBreakpoint
                    [ ( sm, TW.my_20 )
                    , ( lg, TW.my_12 )
                    , ( xl, TW.my_24 )
                    ]
                ]
            ]
            [ div [ css [ TM.contentWrap ] ]
                [ h2
                    [ css
                        [ TW.text_2xl
                        , TW.font_bold
                        , atBreakpoint
                            [ ( sm, TM.h4 )
                            , ( lg, TM.h3 )
                            ]
                        ]
                    ]
                    [ text "Regulations and Laws" ]
                ]
            ]
        , div [ css [ TM.contentWrap ] ]
            [ div
                [ css
                    [ TW.grid
                    , TW.gap_4
                    , atBreakpoint
                        [ ( lg, TW.grid_cols_2 )
                        , ( lg, TW.gap_6 )
                        , ( xl, TW.gap_8 )
                        ]
                    ]
                ]
                (List.map item dataItem)
            ]
        ]
    }


item : Item -> Html msg
item i =
    div
        [ class "item"
        , css
            [ TW.p_6
            , backgroundColor TM.grey_100
            , TW.text_sm
            , TW.rounded_3xl
            , atBreakpoint
                [ ( sm, TW.text_lg )
                , ( sm, TW.leading_9 )
                ]
            ]
        ]
        [ p [ css [ TW.mb_2 ] ] [ text i.description ]
        , a
            [ css [ TM.link ] ]
            [ span [] [ text "Click to open" ], TI.arrowRight ]
        ]


dataItem : List Item
dataItem =
    [ Item "RA Law on Payment and Settlement Systems և Payment and Settlement Organizations" "#"
    , Item "RA Law on Transfer of Funds by Payment Order" "#"
    , Item "Regulation 16/1 - Procedure and Conditions for Issuance, Suspension and Termination of Electronic Money Issuance Permit, Requirements for Electronic Money Issuers" "#"
    , Item "Regulation 16/2 - Procedure and conditions of electronic money issuance and service, requirements for electronic money transactions" "#"
    , Item "Regulation 17/01 - Licensing of Payment and Settlement Organizations, Registration of Branches, Qualification of Heads of Payment and Settlement Organizations, Technical Equipment, Territorial, Software, Security Requirements for the Place of Operation of Payment and Settlement Organizations, and Registration Form" "#"
    , Item "Regulation 17/02 - Regulation of the activity of payment and settlement organizations, economic norms defined for payment and settlement organizations, the procedure for their calculation" "#"
    , Item "Regulation 17/03 - Financial and other reports of payment and settlement organizations, their submission and publication" "#"
    ]
