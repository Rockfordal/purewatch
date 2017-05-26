module Navbar where

import Helpers
import RxJS.Observable as Observable
import OutWatch.Attributes (children, click, cls, href, placeholder, tpe, (:=), (<==), (==>))
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Tags (a, button, div, input, li, text, ul)
import Prelude (const, map, (#), ($), (<>), (==))
import Typer (Action(..), store)

type MenuItem = { label :: String
                , href :: String
                }

navbar :: forall e. Array MenuItem -> String -> VDom e
navbar items current =
  div [ cls := "top-bar"
    , div [cls := "top-bar-left hover-underline-menu", data_ "menu-underline-from-center" := true
        , ul [children <== lists, cls := "menu"
           , li [ a [href := "", cls := "menu-text", text "Website" ] ]
      ]
    ]
    , div [ cls := "top-bar-right"
      , ul [ cls := "dropdown menu", dropdownmenu := true
        , li [ input [tpe := "search", placeholder := "Sök" ]]
        , li [ button [tpe := "button", cls := "button", text "Sök" ]]
        , li [ a [href := "#", text "Admin"]
             , ul[cls := "submenu menu vertical", data_ "submenu" := true
               , li [ a [href := "#", text "Ett"]]
               , li [ a [href := "#", text "Två"]]
               , li [ a [href := "#", text "Tre"]]
               ] ]
        ] ] ]
  where
    lists = Observable.just $ items
      # map \item -> navitem item current


navitem :: forall e. MenuItem -> String -> VDom e
navitem item current =
  li [ cls := aktiv
     , a [href := item.href, mapE click (const (Navigate item.label)) ==> store, text item.label ]
     ] where
    aktiv = item.label == current ? "active" : ""
    -- aktiv = "" -- item.label == current ? "active" : ""
