module Router where

import Lek (lek)
import Myform (myform)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Tags (p, text)
import TodoApp (todoview)

showPage :: forall e. String -> VDom e
showPage current =
  case current of
    "Hem" -> home
    "Enkät" -> myform
    "Lek" -> lek
    "Todo" -> todoview
    _ -> notfound

home :: forall e. VDom e
home = p [ text "Welcome!" ]

notfound :: forall e. VDom e
notfound = p [ text "Not found" ]
