module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation exposing (Key)
import Components.Footer
import Components.Header
import Components.Modal
import Css exposing (..)
import Css.Global exposing (global, selector)
import Html.Events.Extra.Wheel as Wheel
import Html.Styled exposing (div)
import Html.Styled.Attributes exposing (css, href, src)
import Spa.Document exposing (Document)
import TW.Utilities as TW
import Theme.Theme as TM
import Url exposing (Url)
import Utils.Route



-- INIT


type alias Flags =
    ()


type alias Model =
    { url : Url
    , key : Key
    , isOpenMenu : Bool
    , isOpenModal : Bool
    , isOpenLang : Bool
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key False False False
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe
    | OpenMenu Bool
    | OpenModal Bool
    | OpenLang Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        OpenMenu bool ->
            ( { model | isOpenMenu = bool }, Cmd.none )

        OpenModal bool ->
            ( { model | isOpenModal = bool }, Cmd.none )

        OpenLang bool ->
            ( { model | isOpenLang = bool }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW
-- TODO added ModernNormalize.globalStyledHtml


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    { title = page.title
    , body =
        [ globalCss
        , case model.url.path of
            "/error" ->
                div [ css [] ]
                    [ Components.Header.viewErrorHeader
                    , div [ css [] ] page.body
                    ]

            _ ->
                div []
                    [ Components.Header.view
                        { currentRoute = Utils.Route.fromUrl model.url
                        , onToggleMenu = toMsg << OpenMenu
                        , isOpenMenu = model.isOpenMenu
                        , isOpenLang = model.isOpenLang
                        , onToggleModal = toMsg << OpenModal
                        , onToggleLang = toMsg << OpenLang
                        }
                    , div [] page.body
                    , Components.Footer.view { currentRoute = Utils.Route.fromUrl model.url }
                    , Components.Modal.view
                        { onToggleModal = toMsg << OpenModal
                        , isOpenModal = model.isOpenModal
                        }
                    ]
        ]
    }



-- Может двинуть в статику глобальные стили? изучить


globalCss : Html.Styled.Html msg
globalCss =
    let
        font =
            fontFamilies [ qt "Inter", .value sansSerif ]
    in
    global
        [ selector "body" [ backgroundColor TM.white, font, TW.overflow_x_hidden ]
        , selector "input" [ font, TW.w_full ]
        ]
