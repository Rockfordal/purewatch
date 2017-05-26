module Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Prelude (Unit, ($), discard)
import App (app)

foreign import hot :: ∀ eff. Eff eff Unit

main :: Unit
main = unsafePerformEff $ do
  app
  hot
