<?php

//generated from https://chrisblackwell.me/generate-perfect-initials-using-php/

function randomChars($str, $numChars){
    //Return the characters.
    return substr(str_shuffle($str), 0, $numChars);
}