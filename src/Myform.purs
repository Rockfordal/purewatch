module Myform where

import Helpers (abide, abideerror, describedBy)
import OutWatch.Attributes (autofocus, cls, id, novalidate, pattern, placeholder, required, style, tpe, (:=))
import OutWatch.Dom (input)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Tags (div, form, i, label, p, span, text)


myform :: forall e. VDom e
myform =
  form [ novalidate := true, abide := true
    , div [
      cls := "row"
      , div [ cls := "columns"
        , div [ cls := "alert callout", abideerror := true, style := "display: none"
          , p [ i [cls := "fi-alert" ], text "Errors found in your form" ]
          ] ] ]
    , div [ cls := "row"
      , div [ cls := "small-12 columns"
        , label [ text "Användarnamn"
          , input [ tpe := "text"
                  , placeholder := "your Username"
                  , required := true
                  , autofocus := true
                  , pattern := "text"
                  , describedBy := "exampleHelpText"
                  -- , value := state.username
                  -- , HE.onValueInput $ HE.input UpdateUsername
                  ]
          , span [cls := "form-error", text "Hörru, du måste fylla i detta!"]
        ]
      , p [cls := "help-text", id := "exampleHelpText", text "Help text"]
      ]
    , div [ cls := "columns"
      , input [ tpe := "password"
              , placeholder := "your Password"
              , pattern := "password"
              ]
        ]
      ]
    ]

