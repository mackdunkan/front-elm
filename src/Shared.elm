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
import Css.ModernNormalize as ModernNormalize
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events as Event
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import TW.Breakpoints exposing (atBreakpoint, sm, xl)
import TW.Utilities as TW
import Theme.Element as TE
import Theme.Icon as TI
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
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key False False
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe
    | OpenMenu Bool
    | OpenModal Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        OpenMenu status ->
            ( { model | isOpenMenu = status }, Cmd.none )

        OpenModal status ->
            ( { model | isOpenModal = status }, Cmd.none )


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
                        , onToggleModal = toMsg << OpenModal
                        }
                    , div [ css [] ] page.body
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
