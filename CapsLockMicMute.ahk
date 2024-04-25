MicName := "Razer Mic"
MicMuteRequested := true
MicOpenOverlayInCorner := false

ToggleMicMute() {
    global MicMuteRequested := !MicMuteRequested

    CheckMuteState()
}

CheckMuteState() {
    try {
        SyncMuteStates()
        MicOpenOverlay(MicMuteRequested)
    }
}

SyncMuteStates() {
    MicMuteCurrent := SoundGetMute(, MicName)

    if ((MicMuteRequested && !MicMuteCurrent) || (!MicMuteRequested && MicMuteCurrent)) {
        SoundSetMute(MicMuteRequested, , MicName)
    }
}

MicOpenOverlay(MicMuted) {
    static MicGui := ""

    if (!MicMuted && !MicGui) {
        MicGui := CreateGui()
    } else if (MicMuted && MicGui) {
        MicGui.Destroy()
        MicGui := ""
    }

    static CreateGui() {
        NewGui := Gui("-MinimizeBox -Caption +Owner +Border +AlwaysOnTop +Disabled", "MicOpenOverlay")

        NewGui.BackColor := "FFFFFF"
        NewGui.MarginX := 12
        NewGui.MarginY := 8

        NewGui.SetFont("s10 q5", "Calibri")
        NewGui.Add("Text", "xm ym Center c707070 0x200", "MIC OPEN")
        NewGui.Add("Progress", "xm y+m wp h20 cAAFF00 Background707070 vProgress", 100)

        if (MicOpenOverlayInCorner) {
            MonitorGetWorkArea(, , , &WorkAreaX, &WorkAreaY)

            PosX := " x" WorkAreaX - 92 - 8
            PosY := " y" WorkAreaY - 72 - 8

            NewGui.Show("NA" PosX PosY)
        } else {
            NewGui.Show("NA")
        }

        return NewGui
    }
}

#Requires AutoHotkey v2.0-
#Warn
#SingleInstance

SetTimer(CheckMuteState)

CapsLock:: ToggleMicMute()
