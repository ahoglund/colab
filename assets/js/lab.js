import elmApp from "./elm_app"
import Tone from "tone"

var synth = new Tone.MonoSynth({
"portamento" : 0.01,
    "oscillator" : {
      "type" : "square"
    },
    "envelope" : {
      "attack" : 0.005,
      "decay" : 0.2,
      "sustain" : 0.4,
      "release" : 1.4,
    },
    "filterEnvelope" : {
      "attack" : 0.005,
      "decay" : 0.1,
      "sustain" : 0.05,
      "release" : 0.8,
      "baseFrequency" : 300,
      "octaves" : 4
    }
  }).toMaster();

elmApp.ports.playRawSynth.subscribe(function (freq) {
  synth.triggerAttack(freq);
});

elmApp.ports.stopRawSynth.subscribe(function () {
  synth.triggerRelease();
});
