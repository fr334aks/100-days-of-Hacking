-Day 1

I decided to start with the less challenging bits of this journey,which is forensic of wav files and network packet capture

Wav steg

The essential needs for hiding data in wav files include:


-carrier-our audio file 
-message
-password

Audio steg methods


-LSB coding - replacing the least significant bit in some bytes of the cover file


-Parity coding - Break a signal into separate samples and inserts each bit of the secret in a parity bit. If the parity bit of a chosen region does not match the secret bit to be encoded, the procedure inverts the LSB of one of the samples in the region. thus, the sender has different choices in encoding the secret bit


-Phase coding - switching the phase of an initial audio segment with a reference phase that symbolizes the confidential information

.Spread Spectrum - spread confidential information through the frequency spectrum of the audio signal


echo hiding - including an echo into the discrete signal

Deep sound-windows software for wav steg

incase of reference :
https://www.iicybersecurity.com/audio-steganography.html

Hiding secret message in wav file using python code: 
