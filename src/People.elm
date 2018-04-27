module People exposing (people, peopleDisplay)

import Html exposing (Html, li, text, ul)
import List

type alias Person = 
  { name: String
  }

peopleDisplay : List Person -> Html msg
peopleDisplay people =
  ul [] ( List.map nameLi people )

nameLi : Person -> Html msg
nameLi person =
  li [] [ text person.name ]

people = 
  [ { name = "John" }
  , { name = "Julie" }
  , { name = "Jennifer" }
  ]

