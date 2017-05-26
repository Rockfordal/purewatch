module Typer where

import Control.Monad.Eff (Eff)
import Network.HTTP.Affjax (AJAX)
import OutWatch.Dom (VDOM)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Util.Store (Store, createStore)

type AppEff e = Eff (vdom :: VDOM, ajax :: AJAX | e)
type AppVEff e = VDom (ajax :: AJAX | e)

data Action
 = Navigate String

type State = { current :: String }

reducer :: Action -> State -> State
reducer action state = case action of
  (Navigate label) -> state { current = label }

initialState :: State
initialState = { current: "Hem" }

store :: forall e. Store e State Action
store = createStore initialState reducer

