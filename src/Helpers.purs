module Helpers where

import OutWatch.Dom.Builder (BoolAttributeBuilder(..), StringAttributeBuilder(..))
import Prelude (($), (<>))


infixr 3 ifthen as ?
ifthen :: forall a. Boolean -> a -> a -> a
ifthen cond yes =
  (\no -> if cond then yes else no)

infixr 2 ellse as :
ellse :: forall a. a -> a
ellse x = x


describedBy :: StringAttributeBuilder
describedBy = StringAttributeBuilder "aria-describedby"

abideerror :: BoolAttributeBuilder
abideerror = BoolAttributeBuilder "data-abide-error"

abide :: BoolAttributeBuilder
abide = BoolAttributeBuilder "data-abide"

closable :: StringAttributeBuilder
closable = StringAttributeBuilder "data-closable"

close :: BoolAttributeBuilder
close = BoolAttributeBuilder "data-close"

dropdownmenu :: BoolAttributeBuilder
dropdownmenu = BoolAttributeBuilder "data-dropdown-menu"

data_ :: String -> BoolAttributeBuilder
data_ tag = BoolAttributeBuilder $ "data-" <> tag

-- close :: EmptyAttributeBuilder
-- close = EmptyAttributeBuilder "data-close"

-- newtype EmptyAttributeBuilder = EmptyAttributeBuilder String
-- instance emptyAttributeBuilder :: AttributeBuilder EmptyAttributeBuilder Boolean where
--   setTo (EmptyAttributeBuilder name) b =
--     Property (EmptyAttribute { name : name })
    -- Property (Attribute { name : name, value : "" })

