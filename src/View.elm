module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import List.Extra exposing (getAt)
import Models exposing (Model)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Plate Calculator" ]
        , p [] [ text "Enter the total weight you are trying to lift" ]
        , div [] [
            input [ onInput Msgs.EnteredWeight ] []
        ]
        , a [ href "#"
            , id "calculate"
            , class "btn"
            , onClick Msgs.OnCalculateClick
            ] [ text "Calculate" ]
        , calculatedResult model
        ]

calculatedResult: Model -> Html Msg
calculatedResult model =
    if model.shouldShowResults && model.error == "" then
        getNumberOfEachPlate (model.totalPlateWeight) 0 []
            |> getPlateOutputs
            |> renderPlateInfos model
    else
        div [ class "error" ]
            [ p [] [text model.error] ]

getPlateOutputs: List Int -> List String
getPlateOutputs numberOfEachPlate =
    List.map convertNumPlatesToString numberOfEachPlate

convertNumPlatesToString: Int -> String
convertNumPlatesToString number =
    if number > 0 then
        String.concat [(toString number), " on each side"]
    else
        ""

renderPlateInfos: Model -> List String -> Html Msg
renderPlateInfos model plateOutputs =
    div [ id "result" ] (createResults model plateOutputs 0 [])

createResults: Model -> List String -> Int -> List (Html Msg) -> List (Html Msg)
createResults model plateOutputs index accumulatedList =
    if List.length plateOutputs == 0 then
        accumulatedList
    else
        let plateInfo = List.head plateOutputs
                                    |> Maybe.withDefault "blah"
            plateAmount = List.Extra.getAt index model.typesOfPlates
                                        |> Maybe.withDefault "blah"
        in
            if plateInfo /= "" then
                let html = [ p [] [ text (String.concat [plateAmount, "'s -- ", plateInfo]) ]]
                in
                    createResults
                        model
                        (List.drop 1 plateOutputs)
                        (index + 1)
                        (List.append accumulatedList html)
            else
                createResults
                    model
                    (List.drop 1 plateOutputs)
                    (index + 1)
                    (accumulatedList)

getNumberOfEachPlate: Int -> Int -> List Int -> List Int
getNumberOfEachPlate remainingPlateWeight index accumulatedArray =
    if remainingPlateWeight == 0 then
        accumulatedArray
    else
        let
            plateWeights = [90, 70, 50, 20, 10, 5]
            currentPlateWeight = List.Extra.getAt index plateWeights |> Maybe.withDefault 0
        in
            getNumberOfEachPlate
                (remainingPlateWeight % currentPlateWeight)
                (index + 1)
                (List.append accumulatedArray
                [remainingPlateWeight // currentPlateWeight])
