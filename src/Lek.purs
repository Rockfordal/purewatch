module Lek where

import ElmCount (counter)
import Network.HTTP.Affjax (AJAX)
import OutWatch.Attributes (childShow, click, cls, hidden, href, inputChecked, inputString, style, tpe, (:=), (<==), (==>))
import OutWatch.Dom (a, button, div, h2, h3, input, span, text, p, label)
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Http (get)
import OutWatch.Sink (createBoolHandler, createHandler, createStringHandler)
import Prelude (const, map, negate, (#), ($), (+), (<>), (>>>))
import RxJS.Observable (combineLatest, debounceTime, interval, merge, retry, scan, startWith)
import Typer (AppVEff)


lek :: forall e. VDom (ajax :: AJAX | e)
lek = div
    [ div
      [ cls := "row"
      , div[cls := "small-4 columns", blandat]
      , div[cls := "small-4 columns", toggla]
      , div[cls := "small-4 columns", names]
      ]
    , div[cls := "row"
      , div[cls := "small-3 columns", reknare]
      , div[cls := "small-3 columns", tajmer]
      , div[cls := "small-3 columns", counter]
      , div[cls := "small-3 columns", fetch]
      ]
    ]


blandat :: forall e. VDom e
blandat =
  div [ cls := "card", style := "width: 260px"
      , span [cls := "label warning", text "Varning"]
      , label [text "Hide view"]
      , div [text "Tjena", style := "color: green"]
      , a [href := "http://www.intel.com", cls := "success button", text "Add"]
      ]


toggla :: forall e. VDom e
toggla =
    div [ cls := "card", style := "width: 260px"
        , div [cls := "section", text "Toggle"]
        , input [tpe := "checkbox", inputChecked ==> toggleEvents]
        , h2 [text "Im Toggled!", hidden <== toggleEvents.src]
        ] where
        toggleEvents = createBoolHandler[]


reknare :: forall e. VDom e
reknare =
    div [ cls := "card", style := "width: 260px"
        , div [cls := "section", text "Counter"]
        , h3 [childShow <== count]
        , button [cls := "button", mapE click (const (-1)) ==> decH, text "Minska"]
        , button [cls := "button", mapE click (const 1)  ==> incH, text "Öka"]
      ] where
        incH = createHandler[]
        decH = createHandler[]
        count = merge incH.src decH.src
          # scan (+) 0
          # startWith 0


tajmer :: forall e. VDom e
tajmer =
    div [ cls := "card", style := "width: 260px"
        , div [cls := "section", text "Timer"]
        , p [text "Seconds elapsed: ", childShow <== seconds]
        ] where
        seconds = interval 1000
          # map (_ + 1)
          # startWith 100


names :: forall e. VDom e
names =
    div
      [ input[inputString ==> firstNames]
      , input[inputString ==> lastNames]
      , h3 [text "Hello, ", childShow <== fullNames]
      ] where
      firstNames = createStringHandler[""]
      lastNames  = createStringHandler[""]
      fullNames  = combineLatest
                  (\first last -> first <> " " <> last)
                  firstNames.src lastNames.src


fetch :: forall e. (AppVEff e)
fetch =
  let queries = get $
        map (\query -> "https://restcountries.eu/rest/v2/name/" <> query)
        >>> debounceTime 700
        >>> retry 2
      responses = queries.responses
        # map (_.body)
  in div
      [ input[inputString ==> queries]
      , span[childShow <== responses]
      ]