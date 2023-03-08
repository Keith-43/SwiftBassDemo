//
//  AudioManager.swift
//  SwissBassDemo
//
//  The input audio signal is sampled at 44,100 samples per second.
//  Our FFT window of 16,384 samples has a duration of 16,384 / 44,100 = 0.37152 seconds.
//  We calculate a new spectrum every 1/60 seconds, hence our window overlap factor is (0.37152-0.16666)/0.37152 = 55%
//


import Foundation

class AudioManager: ObservableObject {

    static let audioManager = AudioManager() // This singleton instantiates the AudioManager class and runs setupAudio()

    let timeInterval: Double = 1.0 / 60.0		// 60 frames per second
    let micOn: Bool = false
    var stream: HSTREAM = 0

    // Play this song when the SwiftBassDemo app starts:
    let filePath = Bundle.main.path(forResource: "music", ofType: "mp3")

    // Declare an array of the final values (for this frame) that we will publish to the visualization:
    @Published var spectrum: [Float] = [Float]( repeating: 0.0, count: 16384 / 2 )    // binCount = 8,192

    init() { setupAudio() }


    func setupAudio(){

        print( BASS_GetVersion() )   // This prints "33_820_928" in Xcode's console pane

        // Initialize the output device (i.e., speakers) that BASS should use:
        BASS_Init(  -1,         // device: -1 is the default device
                     44100,     // freq: output sample rate is 44,100 sps
                     0,         // flags:
                     nil,       // win: 0 = the desktop window (use this for console applications)
                     nil)       // Unused, set to nil
        // The sample format specified in the freq and flags parameters has no effect on the output on macOS or iOS.
        // The device's native sample format is automatically used.

        if(micOn == true) {

            // Initialize the input device (i.e., microphone) that BASS should use:
            BASS_RecordInit(-1)     // device = -1 is the default input device

            stream = BASS_RecordStart(  44100,          // freq: the sample rate to record at
                                        1,              // chans: number of audio channels, 1 = mono
                                        0,              // flags:
                                        myRecordProc,   // callback process:
                                        nil)            // user:

            func myRecordProc(_: HRECORD, _: UnsafeRawPointer?, _: DWORD, _: UnsafeMutableRawPointer?) -> BOOL32{
                return BOOL32(truncating: true)     // continue recording
            }

        } else {

            // Create a sample stream from our MP3 song file:
            stream = BASS_StreamCreateFile( BOOL32(truncating: false),  // mem: false = stream the file from a filename
                                            filePath,                   // file:
                                            0,                          // offset:
                                            0,                          // length: 0 = use all data up to end of file
                                            0)                          // flags:

            BASS_ChannelPlay(stream, -1) // starts the output
        }

        // Compute the 8192-bin spectrum of the song waveform every 1/60 seconds:
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { time in
            BASS_ChannelGetData(self.stream, &self.spectrum, BASS_DATA_FFT16384)
        }
    }
}
