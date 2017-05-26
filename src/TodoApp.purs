module TodoApp where

import Data.Array (filter, snoc)
import Data.String (length)
import Helpers (closable)
import OutWatch.Attributes (children, click, cls, disabled, for, inputString, text, tpe, value, (:=), (<==), (==>))
import OutWatch.Dom (id)
import OutWatch.Dom.EmitterBuilder (mapE, override)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Sink (SinkLike, createStringHandler)
import OutWatch.Tags (button, div, input, label, li, ul)
import Prelude (const, map, (#), (/=), (<), (<>))
import RxJS.Observable (merge, scan, startWith)


textFieldComponent :: forall e. SinkLike e String _ -> VDom e
textFieldComponent outputEvents =
  let textValues = createStringHandler[]
      disabledValues = textValues.src
        # map (\s -> (length s < 4))
        # startWith true
      clearNewTodo = createStringHandler[]
  in
    div
      [ label [text "Enter new todo item:"
        , input [tpe := "text", inputString ==> textValues, value <== clearNewTodo.src]
      ]
      , button
        [ override click textValues.src ==> outputEvents
        , mapE click (const "") ==> clearNewTodo
        , disabled <== disabledValues
        , cls := "primary button"
        , text "Submit"
        ]
      ]


todoComponent :: forall e. String -> SinkLike e String _ -> VDom e
todoComponent todo deleteEvents =
  li
    [ input [id := ("item-" <> todo), tpe := "checkbox"]
    , label [for := ("item-" <> todo), text todo]
    , button [cls := "alert button tiny", mapE click (const todo) ==> deleteEvents, text "x"]
    ]


todoview :: forall e. VDom e
todoview =
  let addEvents    = createStringHandler[]
      deleteEvents = createStringHandler[]

      addToList      todo list = snoc list todo
      removeFromList todo list = list # filter (_ /= todo)

      additions = addEvents.src    # map addToList
      deletions = deleteEvents.src # map removeFromList
      merged = merge additions deletions

      state = (merge additions deletions)
        # scan (\modify list -> modify list) []

      listViews = state
        # map (map (\todo -> todoComponent todo deleteEvents))
  in
    div
      [ cls := "todo-list-card card", closable := "fade-out"
      , div [cls := "card-divider"
        , textFieldComponent addEvents
        -- , button [cls := "close-button", close := true, text "x"]
        ]
      , div [cls := "card-section"
        , ul[children <== listViews]
        ]
      ]
