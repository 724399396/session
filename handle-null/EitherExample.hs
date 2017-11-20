import Prelude hiding (Either(..))

data Hero = Hero { weaponId:: Int } deriving Show
data Weapon = Weapon { gemId:: Int } deriving Show
data Gem = Gem deriving Show

data Either a b = Left a | Right b deriving Show

type StringEither a = Either String a

getHero :: Int -> StringEither Hero
getHero 0 = Left "hero not exist"
getHero 1 = Right (Hero 1)
getHero 2 = Right (Hero 2)

getWeapon :: Int -> StringEither Weapon
getWeapon 1 = Left "weapon not exist"
getWeapon 2 = Right (Weapon 1)

getGem :: Int -> StringEither Gem
getGem 1 = Right Gem

getGemByHero :: Int -> StringEither Gem
getGemByHero id = case getHero id of
  Left x -> Left x
  Right hero -> case getWeapon (weaponId hero) of
    Left x -> Left x
    Right weapon -> getGem (gemId weapon)

bind :: Either a b -> (b -> Either a c) -> Either a c
bind (Left a) _ = Left a
bind (Right b) f = f b

getGemByHeroV2 :: Int -> StringEither Gem
getGemByHeroV2 id = (getHero id) `bind` (\hero -> getWeapon (weaponId hero)) `bind` (\weapon -> getGem (gemId weapon))

instance Functor (Either a) where
  fmap _ (Left x) = Left x
  fmap f (Right x) = Right $ f x

instance Applicative (Either a) where
  pure x = Right x
  Left x <*> _ = Left x
  _ <*> Left x = Left x
  (Right f) <*> (Right x) = Right $ f x

instance Monad (Either a) where
  return = pure
  (>>=) = bind

getGemByHeroV3 id = (getHero id) >>= (getWeapon . weaponId) >>= (getGem . gemId)

getGemByHeroV4 id = do hero <- getHero id
                       weapon <- getWeapon (weaponId hero)
                       getGem (gemId weapon)
