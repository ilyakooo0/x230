module Galmuri exposing (..)

import Element
import Element.Font as Font


type alias Font msg =
    Int
    -> List (Element.Attribute msg)


body : List (Element.Attribute msg)
body =
    galmuri11 1


subtitle : List (Element.Attribute msg)
subtitle =
    galmuri11 2


title : List (Element.Attribute msg)
title =
    galmuri11Bold 3


galmuri11 : Font msg
galmuri11 scale =
    [ Font.family [ Font.typeface "Galmuri11" ], Font.size <| scale * 12 ]


galmuri11Bold : Font msg
galmuri11Bold scale =
    [ Font.family [ Font.typeface "Galmuri11" ], Font.size <| scale * 12, Font.bold ]


galmuri9 : Font msg
galmuri9 scale =
    [ Font.family [ Font.typeface "Galmuri9" ], Font.size <| scale * 10 ]
