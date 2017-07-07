module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnCalculateClick ->
            if model.enteredWeight == 0 then
                ( { model | shouldShowResults = False,
                            error = "Please enter a weight!" }, Cmd.none )
            else if model.enteredWeight % 5 /= 0 then
                ( { model | shouldShowResults = False,
                            error = "Weight must be divisible by 5!" }, Cmd.none )
            else
                ( { model | shouldShowResults = True,
                            totalPlateWeight = model.enteredWeight - model.barWeight,
                            error = "" }, Cmd.none )

        Msgs.EnteredWeight weight ->
            let weightAsInt = String.toInt weight |> Result.toMaybe |> Maybe.withDefault 0
            in
                ( { model | enteredWeight = weightAsInt,
                            error = "" }, Cmd.none )
