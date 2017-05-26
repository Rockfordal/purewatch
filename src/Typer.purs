module Typer where

import OutWatch.Util.Store (Store, createStore)


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

