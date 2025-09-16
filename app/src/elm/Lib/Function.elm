module Lib.Function exposing (flip, uncurry)


flip : (a -> b -> c) -> b -> a -> c
flip f b a =
    f a b


uncurry : (a -> b -> c) -> ( a, b ) -> c
uncurry f ( a, b ) =
    f a b
