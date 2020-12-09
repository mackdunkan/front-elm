module Pages.Help exposing (Model, Msg, Params, page)

import Css exposing (animationDuration, animationIterationCount, animationName, backgroundColor, borderColor, hover, int, sec)
import Css.Animations exposing (keyframes, property)
import Css.Transitions exposing (transition)
import Html.Styled exposing (Html, a, div, h2, h4, p, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import TW.Breakpoints exposing (atBreakpoint, lg, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
import Theme.Theme as TM
import Utils.Directive as DR


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
    { activeItem : Int
    , parentItem : Int
    }


type alias Faq =
    { title : String
    , items : List Item
    }


type alias Item =
    { title : String
    , content : String
    }


init : Url Params -> Model
init { params } =
    { activeItem = 0
    , parentItem = 0
    }



-- UPDATE


type Msg
    = OpenItem Int Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        OpenItem parentId itemId ->
            { model
                | activeItem = itemId
                , parentItem = parentId
            }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help"
    , body =
        [ TE.pageTitleSection "Help" ""
        , div
            [ css
                [ TW.mb_12
                , atBreakpoint
                    [ ( sm, TW.mb_16 )
                    , ( lg, TW.mb_24 )
                    ]
                ]
            ]
            [ div [ css [ TM.contentWrap ] ]
                [ sectionStore ]
            ]
        , div [ css [ TW.mb_6 ] ]
            [ div [ css [ TM.contentWrap ] ]
                [ h2
                    [ css
                        [ TW.text_2xl
                        , TW.font_bold
                        , atBreakpoint
                            [ ( sm, TM.h4 )
                            , ( lg, TM.h2 )
                            ]
                        ]
                    ]
                    [ text "FAQ" ]
                ]
            ]
        , div [ css [ atBreakpoint [ ( sm, TM.contentWrap ) ] ] ]
            (List.indexedMap (\id e -> sectionFAQ model id e) dataFaq)
        ]
    }


sectionStore : Html msg
sectionStore =
    div
        [ css
            [ TW.mx_auto
            , atBreakpoint
                [ ( sm, TW.w_3over4 )
                , ( lg, TW.w_7over12 )
                , ( xl, TW.w_6over12 )
                ]
            ]
        ]
        [ p
            [ css
                [ TW.text_lg
                , TW.font_bold
                , TW.text_center
                , TW.mb_4
                , atBreakpoint
                    [ ( sm, TW.text_2xl )
                    , ( sm, TW.mb_8 )
                    , ( lg, TM.h4 )
                    , ( lg, TW.mb_12 )
                    ]
                ]
            ]
            [ text "Get professional assistance from our support team through our user-friendly chats in the app!" ]
        , div
            [ css
                [ TW.grid
                , TW.gap_4
                , TW.mx_auto
                , atBreakpoint [ ( sm, TW.w_4over5 ), ( sm, TW.grid_cols_2 ) ]
                ]
            ]
            [ div [] [ TE.btnStoreAndroid ]
            , div [] [ TE.btnStoreApple ]
            ]
        ]


sectionFAQ : Model -> Int -> Faq -> Html Msg
sectionFAQ model sectionId f =
    div [ css [ TW.my_8 ] ]
        [ h4
            [ css
                [ TW.font_bold
                , TW.text_lg
                , TW.px_4
                , atBreakpoint
                    [ ( sm, TW.px_0 )
                    , ( sm, TW.text_2xl )
                    ]
                ]
            ]
            [ text f.title ]
        , div
            [ css
                [ TW.mt_8
                , TW.divide_y
                , TW.border_t
                , TW.border_b
                , borderColor TM.grey_300
                , atBreakpoint
                    []
                ]
            ]
            (List.indexedMap (\idx e -> item model sectionId idx e) f.items)
        ]


item : Model -> Int -> Int -> Item -> Html Msg
item model sectionId idx i =
    let
        isActive =
            if model.activeItem == idx && model.parentItem == sectionId then
                True

            else
                False
    in
    div [ css [ atBreakpoint [] ] ]
        [ div
            [ css
                [ TW.p_4
                , TW.flex
                , TW.flex_row
                , TW.justify_between
                , TW.items_center
                , TW.text_sm
                , atBreakpoint
                    [ ( sm, TW.text_lg )
                    ]
                ]
            ]
            [ div
                [ css
                    [ TW.font_bold
                    ]
                ]
                [ text <| i.title ]
            , div
                [ onClick (OpenItem sectionId idx)
                , css
                    [ TW.cursor_pointer
                    , TW.rounded_full
                    , TW.transform
                    , TW.duration_300
                    , TW.ease_in_out
                    , TW.rotate_0
                    , DR.stylesIfTrue [ TW.rotate_45 ] isActive
                    , hover [ backgroundColor TM.grey_300 ]
                    ]
                ]
                [ TI.closeCurcle ]
            ]
        , div
            [ css
                [ TW.transition_all
                , TW.max_h_0
                , TW.duration_300
                , TW.ease_in_out
                , TW.delay_150
                , TW.overflow_hidden
                , borderColor TM.grey_300
                , DR.stylesIfTrue [ TW.max_h_screen, TW.border_t ] isActive
                ]
            ]
            [ p [ css [ TW.p_4 ] ] [ text i.content ] ]
        ]


dataFaq : List Faq
dataFaq =
    [ Faq "General"
        [ Item
            "What is mePay?"
            "mePay is an app that provides financial services and solutions. In the future, the app will partner with a bank so users can receive payment cards and all the benefits of a bank as well."
        , Item
            "How do I get a mePay account?"
            "Simply download the app and sign up."
        , Item
            "Is my money safe with mePay?"
            "Yes. mePay has a Payment and Settlement Organization License issued by the Central Bank of Armenia and is a legally recognized financial payments service provider."
        , Item
            "Do I need to be a resident of a particular country?"
            "No. mePay is meant to be a global app that provides financial services even to those users across the world and seeks to make banking more inclusive."
        , Item
            "What age do I need to be?"
            "mePay users need to be 14 years of age or older to hold an account."
        , Item
            "Why can't I login to my mePay account?"
            "If you are experiencing technical difficulties please contact our support team through the online chat or at +374 60 544 000."
        ]
    , Faq "Support and Chats"
        [ Item
            "How do I contact support?"
            "The support staff is ready to help you with any questions. For your convenience, all correspondence can be conducted through a user friendly chat feature"
        , Item
            "How do I complain?"
            "We value all feedback from our customers. Message our support team if you encounter any problems or cannot perform certain actions."
        ]
    , Faq "Cards"
        [ Item
            "Does mePay provide bank cards?"
            "Soon mePay will partner with banks to provide co-branded banking cards so users can fully take advantage of all types of financial services."
        ]
    , Faq "Payments"
        [ Item
            "What type of payments can I make from the wallet?"
            "Soon mePay will partner with banks to provide co-branded banking cards so users can fully take advantage of all types of financial services."
        ]
    ]
