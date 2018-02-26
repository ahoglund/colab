import elmApp from "./elm_app"

elmApp.ports.playRawSynth.subscribe(function (freq) {
  synth.triggerAttack(freq);
});

elmApp.ports.stopRawSynth.subscribe(function () {
  synth.triggerRelease();
});
