module Models exposing (..)

type alias Model =
    { barWeight: Int
    , enteredWeight: Int
    , totalPlateWeight: Int
    , typesOfPlates: List String
    , shouldShowResults: Bool
    , error: String
    }


initialModel : Model
initialModel =
    { barWeight = 45
    , enteredWeight = 0
    , totalPlateWeight = 0
    , typesOfPlates = ["45", "35", "25", "10", "5", "2.5"]
    , shouldShowResults = False
    , error = ""
    }
