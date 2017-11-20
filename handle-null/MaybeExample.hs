import Prelude hiding (Maybe(..))

data Hero = Hero { weaponId:: Int } deriving Show
data Weapon = Weapon { gemId:: Int } deriving Show
data Gem = Gem deriving Show

data Maybe a = Nothing | Just a deriving Show

getHero :: Int -> Maybe Hero
getHero 0 = Nothing
getHero 1 = Just (Hero 1)
getHero 2 = Just (Hero 2)

getWeapon :: Int -> Maybe Weapon
getWeapon 1 = Nothing
getWeapon 2 = Just (Weapon 1)

getGem :: Int -> Maybe Gem
getGem 1 = Just Gem

getGemByHero :: Int -> Maybe Gem
getGemByHero id = case getHero id of
  Nothing -> Nothing
  Just hero -> case getWeapon (weaponId hero) of
    Nothing -> Nothing
    Just weapon -> getGem (gemId weapon)

bind :: Maybe a -> (a -> Maybe b) -> Maybe b
bind Nothing  f = Nothing
bind (Just a) f = f a

getGemByHeroV2 :: Int -> Maybe Gem
getGemByHeroV2 id = (getHero id) `bind` (\hero -> getWeapon (weaponId hero)) `bind` (\weapon -> getGem (gemId weapon))

instance Functor Maybe where
  fmap _ Nothing = Nothing
  fmap f (Just x) = Just $ f x

instance Applicative Maybe where
  pure x = Just x
  Nothing <*> _ = Nothing
  _ <*> Nothing = Nothing
  (Just f) <*> (Just x) = Just $ f x

instance Monad Maybe where
  return = pure
  (>>=) = bind

getGemByHeroV3 id = (getHero id) >>= (getWeapon . weaponId) >>= (getGem . gemId)

getGemByHeroV4 id = do hero <- getHero id
                       weapon <- getWeapon (weaponId hero)
                       getGem (gemId weapon)
