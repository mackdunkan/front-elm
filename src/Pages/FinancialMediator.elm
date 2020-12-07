module Pages.FinancialMediator exposing (Model, Msg, Params, page)

import Html.Styled exposing (Html, a, div, h4, p, text)
import Html.Styled.Attributes exposing (css, href, target)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, md, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
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



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "FinancialMediator"
    , body =
        [ TE.pageTitleSection "Financial Mediator"
        , div
            [ css
                [ TW.grid
                , TW.gap_6
                , atBreakpoint [ ( lg, TW.grid_cols_2 ) ]
                ]
            ]
            [ div []
                [ div [ css [ TM.contentWrap ] ]
                    [ section
                    ]
                ]
            , div [ css [ TM.contentWrap ] ]
                [ sectionInfo
                ]
            ]
        ]
    }


section : Html msg
section =
    div [ css [ atBreakpoint [ ( xl, TW.pr_36 ) ] ] ]
        [ h4
            [ css
                [ TW.text_2xl
                , TW.font_bold
                , TW.mb_2
                , atBreakpoint
                    [ ( sm, TM.h4 )
                    , ( sm, TW.mb_6 )
                    ]
                ]
            ]
            [ text "Financial mediator" ]
        , p [] [ text "Established pursuant to the Republic of Armenia Law on Financial System Mediator, the Office has been functioning since January 24, 2009. Its founder is the Central Bank of Armenia." ]
        ]


sectionInfo : Html msg
sectionInfo =
    let
        phone : String
        phone =
            "(+374 60) 70-11-11"

        fax : String
        fax =
            "(+374 10) 58-24-21"

        email : String
        email =
            "info@fsm.am"

        web : String
        web =
            "www.fsm.am"
    in
    div [ css [ TW.relative, TW.z_10, atBreakpoint [ ( md, TW.gap_6 ), ( lg, TW.gap_8 ) ], TW.grid, TW.gap_4 ] ]
        [ TE.infoItem False "Phone number" <| a [ href <| "tel:" ++ phone ] [ text phone ]
        , TE.infoItem False "Fax number" <| a [ href <| "tel:" ++ fax ] [ text fax ]
        , TE.infoItem False "E-mail" <| a [ href <| "mailto:" ++ email ] [ text email ]
        , TE.infoItem False "Web page:" <| a [ target "_blank", href <| "https://" ++ web ] [ text web ]
        , TE.infoItem False "Working hours:" <|
            div []
                [ p [] [ text "Monday–Friday: from 9:00 am to 6:00 pm" ]
                , p [] [ text "Lunch time: 1:00 pm to 2:00 pm" ]
                ]
        , TE.infoItem False "Address" <|
            div []
                [ p [] [ text "0010 Yerevan, Armenia" ]
                , p [] [ text "15 Khorenatsi str., “Elite Plaza” Business Center, 7th floor" ]
                ]
        ]
