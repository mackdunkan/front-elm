module Components.Footer exposing (..)

import Css exposing (backgroundColor)
import Html.Styled exposing (Html, div, footer, text)
import Html.Styled.Attributes exposing (css)
import Spa.Generated.Route exposing (Route)
import TW.Utilities as TW
import Theme.Theme as TM


type alias Options =
    { currentRoute : Route
    }


view : Options -> Html msg
view options =
    footer []
        [ div [ css [ TM.contentWrap ] ]
            [ div [ css [ TW.grid, TW.grid_cols_2 ] ]
                [ div [] [ text "left" ]
                , div [ css [ TW.relative ] ]
                    [ div [ css [ TW.absolute, TW.inset_0, TW.h_full, TW.w_screen, backgroundColor TM.green ] ] []
                    ]
                ]
            ]
        ]
