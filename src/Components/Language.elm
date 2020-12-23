module Components.Language exposing (..)

import Css exposing (backgroundColor, color, focus, hover, maxHeight, px)
import Html.Styled exposing (Html, button, div, li, text, ul)
import Html.Styled.Attributes exposing (class, css)
import TW.Breakpoints exposing (atBreakpoint, lg)
import TW.Utilities as TW
import Theme.Theme as TM
import Utils.Directive as DR


type Language
    = HY
    | EN


default : Language
default =
    EN


toString : Language -> String
toString language =
    case language of
        EN ->
            "en"

        HY ->
            "hy"
