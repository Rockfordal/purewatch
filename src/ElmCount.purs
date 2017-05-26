module ElmCount where

import Data.Array (filter, snoc)
import Data.String (length)
import Helpers (closable, close)
import OutWatch.Attributes (child, childShow, children, click, cls, disabled, for, inputString, text, tpe, value, (:=), (<==), (==>))
import OutWatch.Dom.EmitterBuilder (mapE, override)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Sink (SinkLike, createHandler, createStringHandler)
import OutWatch.Tags (button, div, h3, input, label, li, span, ul)
import OutWatch.Util.Store (createStore)
import Prelude (const, map, (#), ($), (+), (-), (/=), (<), (<>))
import RxJS.Observable (scan, startWith)

data Action = Add | Subtract

type State = Int

initialState :: State
initialState = 0

reducer :: Action -> State -> State
reducer action previousState =
  case action of
    Add -> previousState + 1
    Subtract -> previousState - 1


counter :: forall e. VDom e
counter =
 let store = createStore initialState reducer
 in div
  [ button[mapE click (const Add) ==> store, text "+"]
    , button[mapE click (const Subtract) ==> store, text "-"]
    , span[text "Count:", childShow <== store.src]
  ]


-- vy2 :: forall e. VDom e
-- vy2 =
--   let storeSink = createHandler[]
--       storeSource = storeSink.src
--         # scan reducer initialState
--         # startWith initialState
--   in div
--     [ button[mapE click (const Add) ==> storeSink, text "+"]
--     , button[mapE click (const Subtract) ==> storeSink, text "-"]
--     , span[text "Count:", childShow <== storeSource] ]
