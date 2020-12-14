module Utils.Attr exposing (retinaImg)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (attribute)


retinaImg : String -> List (Attribute msg)
retinaImg path =
    let
        add2x str =
            String.replace "." "@2x." str
    in
    [ attribute "srcset" <| path ++ " 1x" ++ "," ++ add2x path ++ " 2x"
    ]
