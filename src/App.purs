module App where

import Navbar (navbar)
import OutWatch.Attributes (child, (<==))
import OutWatch.Core (render)
import OutWatch.Dom (div)
import Prelude (Unit, map, (#))
import Router (showPage)
import Typer (AppEff, store)

-- app :: forall e. Eff ( vdom :: VDOM | e ) Unit
app :: forall e. AppEff e Unit
app = let
      menuItems = [ { label: "Hem",   href: "http://www.ibm.com" }
                  , { label: "Enkät", href: "http://www.amd.com" }
                  , { label: "Lek",   href: "http://www.nvidia.com" }
                  , { label: "Todo",  href: "http://www.hp.com" }
                  ]
      currentView = store.src # map _.current # map showPage
      navbarView  = store.src # map _.current # map (navbar menuItems)
      root =
        div [ child <== currentView
            , child <== navbarView
            ]
  in render "#app" root

