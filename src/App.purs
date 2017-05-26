module App where

import Typer (store)
import Control.Monad.Eff (Eff)
import Navbar (navbar)
import OutWatch.Attributes (child, (<==))
import OutWatch.Core (render)
import OutWatch.Dom (div)
import Prelude (Unit, map, (#))
import Router (showPage)
import Snabbdom (VDOM)


app :: forall e. Eff ( vdom :: VDOM | e ) Unit
app = let
      menuItems = [ { label: "Hem",   href: "http://www.ibm.com" }
                  , { label: "Enkät", href: "http://www.amd.com" }
                  , { label: "Lek",   href: "http://www.nvidia.com" }
                  , { label: "Todo",  href: "http://www.hp.com" }
                  ]
      -- currentvalues = store.src # map _.current
      currentView = store.src # map (\state -> state.current) # map showPage
      navbarView = store.src # map (\state -> state.current) # map (navbar menuItems)
      root =
        div [ child <== currentView
            , child <== navbarView
            ]
  in render "#app" root