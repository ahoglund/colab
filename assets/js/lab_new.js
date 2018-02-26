import Tone from "tone"
import socket from "./socket"
const appDiv = document.querySelector('#app-container');
const lab_id = appDiv.getAttribute("data-lab-id");
let channel = socket.channel("lab:room:" + lab_id, {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

Nexus.colors.accent = "#f5871f"
var bpm = new Nexus.Number('#lab-bpm',{
  'size': [60,30],
  'min': 30,
  'max': 250,
  'step': 1
})

var synth = new Tone.PolySynth({
  "portamento" : 0.01,
  "oscillator" : {
    "type" : "triangle"
  },
  "envelope" : {
    "attack" : 0.005,
    "decay" : 0.2,
    "sustain" : 0.4,
    "release" : 0.4,
  },
  "filterEnvelope" : {
    "attack" : 0.005,
    "decay" : 0.1,
    "sustain" : 0.05,
    "release" : 0.8,
    "baseFrequency" : 600,
    "octaves" : 4
  }
}).toMaster();

var synth_one = new Nexus.Piano('#lab-rack-1-keyboard', {
 'size': [400,100],
 'lowNote': 72,
 'highNote': 85
});

var sequencer = new Nexus.Sequencer('#lab-rack-1-sequencer', {
 'size': [400,200],
 'mode': 'toggle',
 'rows': 13,
 'columns': 8
})

channel.on("metronome_tick", msg => sequencer.next() )

bpm.on('change',function(v) {
  channel.push("update_bpm", {bpm: v}, 10000)
    .receive("ok", (msg) => console.log("created message", msg) )
    .receive("error", (reasons) => console.log("create failed", reasons) )
    .receive("timeout", () => console.log("Networking issue...") )
})

let midiToFreqArray = new Array(127);
let tuneTo = 220; //hz
for(let x = 0; x < 127; ++x){
   midiToFreqArray[x] = (tuneTo / 32) * (2 ** ((x - 9) / 12));
}

sequencer.on('change',function(v) {
  channel.push("update_cell", {track_id: v.column, is_active: v.state, id: v.row}, 10000)
    .receive("ok", (msg) => console.log("created message", msg) )
    .receive("error", (reasons) => console.log("create failed", reasons) )
    .receive("timeout", () => console.log("Networking issue...") )
})

channel.on("update_cell", msg => sequencer.matrix.toggle.cell(msg.track_id, msg.id))

sequencer.on('step',function(column) {
  for (var i = 0; i < 13; i++){
    if (column[i] === 1){
      synth.triggerAttackRelease(midiToFreqArray[i + 72], 0.1);
    }
  }
})

synth_one.on('change',function(synth_one_action) {
  if(synth_one_action.state == true) {
    var note = midiToFreqArray[synth_one_action.note];
    synth.triggerAttack(note);
  } else if(synth_one_action.state == false) {
    synth.triggerRelease();
  };
})
