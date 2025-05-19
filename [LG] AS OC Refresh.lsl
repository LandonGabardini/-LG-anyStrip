/*
 * [LG] AS OC Refresh.lsl
 * Author: Landon Gabardini
 * Copyright 2025, Landon Gabardini
 *
 * Use/modify this script to refresh the [LG] anyStrip outfit
 * when an OC-compatible device exits a pose. This is only
 * useful and recommended in combination with products like
 * [LG] Feet AutoSelect for Legacy, Maitreya & Reborn to restore
 * the hover height when existing a OC-device pose (e.g. kneel).
 */

// the channel, default 2 (since version 4.x)
integer intChannel = 2;

// the prefix (set here, if not default)
string strPrefix = "";

key gKeyOwner;          // the wearer's UUID
integer gIntOCChannel;  // the channel for OC notifications
integer gIntOCHandler;  // handler for the above channel

fnInitialise() {
    // get owner
    gKeyOwner = llGetOwner();
    // if empty, set the default prefix
    if(strPrefix=="") {
        // (first two characters of legacy name)
        strPrefix = llGetSubString(
            llToLower(llGetUsername(llGetOwner())), 0, 1
        );
    }
    // determine channel based on UUID
    gIntOCChannel = (integer)("0x" + llGetSubString(gKeyOwner, 30, -1));
    if (gIntOCChannel > 0) {
        gIntOCChannel = -gIntOCChannel;
    }
    // close and re-open listener
    llListenRemove(gIntOCHandler);
    gIntOCHandler = llListen(gIntOCChannel, "", NULL_KEY, "");
}

default
{
    state_entry(){
        // initialise the script
        fnInitialise();
    }
    
    listen(integer channel, string name, key id, string msg) {
        // if is not owned by current user
        if(gKeyOwner!=llGetOwnerKey(id)) return;
        // if message contains ZHAO_STANDON (exiting pose)
        if(~llSubStringIndex(msg, "ZHAO_STANDON")) {
            // update anystrip
            llSay(2, "yarefresh");
        }
    }

    changed(integer change) {
        // if owner changed
        if(change & CHANGED_OWNER) {
            // re-initialise
            fnInitialise();
        }
    }
}
