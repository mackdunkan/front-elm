module Shared exposing
    ( Flags
    , Model
    , Msg
    , Status(..)
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation as Nav exposing (Key)
import Components.Footer
import Components.Header
import Components.Language as Language exposing (Language(..))
import Components.Modal
import Css exposing (..)
import Css.Global exposing (global, selector)
import Html.Styled exposing (div, text)
import Html.Styled.Attributes exposing (css)
import Http
import Json.Decode as Decode exposing (Decoder, decodeString)
import Json.Encode as Encode
import Ports
import RemoteData exposing (WebData)
import Spa.Document exposing (Document)
import TW.Utilities as TW
import Theme.Theme as TM
import Translations exposing (Translations)
import Url exposing (Url)
import Url.Builder
import Utils.Route



-- INIT


type alias Flags =
    ()


type Status
    = Pending
    | Failed Http.Error
    | Initialised Translations


type alias Model =
    { url : Url
    , key : Key
    , language : Language
    , status : Status
    , isOpenMenu : Bool
    , isOpenModal : Bool
    , isOpenLang : Bool
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key Language.default Pending False False False
    , fetchTranslations Language.default
    )



-- UPDATE


type Msg
    = ReplaceMe
    | OpenMenu Bool
    | OpenModal Bool
    | OpenLang Bool
    | GotTranslations (Result Http.Error Translations)
    | SelectLang Language


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

        GotTranslations (Ok translations) ->
            ( { model | status = Initialised translations }, Cmd.none )

        GotTranslations (Err error) ->
            ( { model | status = Failed error }, Cmd.none )

        SelectLang lang ->
            ( { model | language = lang }, Cmd.batch [ saveLanguage lang ] )


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
        , case model.status of
            Pending ->
                div [] [ text "Loading ... " ]

            Failed _ ->
                div [] [ text "Fetching translations failed" ]

            Initialised t ->
                case model.url.path of
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
                                , language = model.language
                                , onSelectedLang = toMsg << SelectLang
                                }
                            , div [] page.body
                            , Components.Footer.view { currentRoute = Utils.Route.fromUrl model.url }
                            , Components.Modal.view
                                { onToggleModal = toMsg << OpenModal
                                , isOpenModal = model.isOpenModal
                                , language = model.language
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
        , selector "input" [ font, TW.w_full, focus [ borderColor TM.grey_700, TW.outline_none ] ]
        ]


fetchTranslations : Language -> Cmd Msg
fetchTranslations language =
    Http.get
        { url = Url.Builder.absolute [ Language.toString language ++ ".json" ] []
        , expect = Http.expectJson GotTranslations Translations.decoder
        }


saveLanguage : Language -> Cmd msg
saveLanguage lang =
    Encode.string (Language.toString lang)
        |> Encode.encode 0
        |> Ports.storeLang


langDecoder : Decoder String
langDecoder =
    Decode.field "key" Decode.string


decodeStoredPosts : String -> WebData String
decodeStoredPosts langJson =
    case decodeString langDecoder langJson of
        Ok lang ->
            RemoteData.succeed lang

        Err _ ->
            RemoteData.Loading
