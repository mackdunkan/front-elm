module Utils.Directive exposing (stylesIfTrue)

import Css


stylesIfTrue : List Css.Style -> Bool -> Css.Style
stylesIfTrue styles isOpen =
    if isOpen then
        Css.batch styles

    else
        Css.batch []
