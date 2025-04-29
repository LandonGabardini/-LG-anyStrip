/*
 * [LG] AS Click Relay.lsl
 * Author: Landon Gabardini
 * Copyright 2025, Landon Gabardini
 *
 * Use/modify this script to open the [LG] anyStrip menu
 * from within another scripted object. It will relay the
 * id of the user touching this object to the [LG] anyStrip. 
 *
 */

// the channel, default 2 (since version 4.x)
integer intChannel = 2;

// the prefix (set here, if not default)
string strPrefix = "";

default {
    state_entry() {
        // if empty, set the default prefix
        if(strPrefix=="") {
            // (first two characters of legacy name)
            strPrefix = llGetSubString(
                llToLower(llGetUsername(llGetOwner())), 0, 1
            );
        }
    }

    touch_start(integer total_number) {
        // call the anystrip and provide the key
        // of the user touching the object
        llSay(
            intChannel,
            // prefix
            strPrefix
            // command 'anystrip'
            + "anystrip "
            // the key of the user touching the object
            + (string)llDetectedKey(0));
    }
}
