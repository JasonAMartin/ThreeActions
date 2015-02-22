//
//  ErrorDictionary.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

//This file holds all responses

import Foundation


var AppResponseDictionary: [String:String] = [
    "createAccountSuccess": "Your account was created.\nClick the button to continue."
]




//creating error dictionary for PARSE responses so I can customize my display

var ParseErrorDictionary: [Int:String] = [
    1: "We're sorry, but our data provider, Parse, had a server error. Please try again now and/or later.", //internal server error
    100: "Connection to Parse failed. Please try again.",
    102: "It looks like our app is trying to get data from a source that doesn't exist. Please try again and let us know if this problem happens again.", //invalid query
    124: "We couldn't connect to the data provider. Please try again or later if the problem persists. Thank you.", //timeout
    125: "Your email isn't valid. Please fix your email and try again. Thank you.", //invalid email
    137: "Looks like there's a duplicate value for your data. Please try to fix this and try again.", //dupe value
    200: "Please provide a username.", //username missing.
    201: "Please provide a password.", //password missing
    202: "Sorry, the username you've chosen is taken already. Please try another username.", //username taken
    203: "Sorry, but that email is taken already.", //email taken
    204: "Please provide your email.", //email missing
    205: "Sorry, your email wasn't found. Please check its spelling and try again.", //email not found
    206: "Looks like there's something missing in your session. Please try again or report your error code (206).", //session error
    207: "Looks like there's an issue creating your user account. Please make sure you're using our app properly. If so, please report this issue.", //mustcreateuserthroughsignup
    208: "Your account is already linked.", //account already linked
    250: "Linked ID is missing in your request. Please try again.", //linked ID missing
    252: "There was a general error with our data provider. If this persists, please report this unsupported service notice (error: 252)", //unsupported service
    909090: "There was an unknown error processing your request to Parse. Please try again. You can also contact us and mention your error code."
]
