module HelperFunctions exposing (..)

import CustomTypes exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as Sat

import Html exposing (text, button, Html)
import Html.Events exposing (onClick)
import Html.Attributes as At

import Components exposing (svgEllipse, svgRect, svgLine)

getSelectedShape : List Shape -> Int -> Shape
getSelectedShape listToFilter id =
    let
        filterList = List.head <| List.filter (\shape -> shape.id == id) listToFilter
    in
    case filterList of
        Just shape ->
            shape
        Nothing -> 
            Shape 1 Ellipse "50" "50" "50" "50" "blue" "Shape 1" "5" "red"

convertToCode : Model -> String
convertToCode model = 
    let 
        st = model.inputShapeType
        x = model.inputXPos
        y = model.inputYPos
        w = model.inputWidth
        h = model.inputHeight
        c = model.inputColor
    in
    if st == Ellipse then
        String.concat
            [ "<ellipse cx=\'", x
            , "\' cy=\'" ++ y
            , "\' rx=\'" ++ w
            , "\' ry=\'" ++ h
            , "\' fill=\'" ++ c
            , "\'/>"
            ]
    else if st == Rectangle then
        String.concat
            [ "<rect x=\'", x
            , "\' y=\'" ++ y
            , "\' width=\'" ++ w
            , "\' height=\'" ++ h
            , "\' fill=\'" ++ c
            , "\'/>"
            ]
    else
        String.concat
            [ "<line x1=\'", x
            , "\' y1=\'" ++ y
            , "\' x2=\'" ++ w
            , "\' y2=\'" ++ h
            , "\' stroke=\'" ++ c
            , "\'/>"
            ]

convertToSvg : Model -> List (Svg Msg)
convertToSvg model = 
    List.map (\shape ->
        if shape.shapeType == Ellipse then
            Svg.g []
                [ svgEllipse shape model
                ]
        else if shape.shapeType == Rectangle then
            Svg.g []
                [ svgRect shape model
                ]
        else
            Svg.g []
                [ svgLine shape model
                ]
        ) model.svgShapes
