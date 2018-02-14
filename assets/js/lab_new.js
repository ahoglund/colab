Nexus.colors.accent = "#f5871f"
//var piano     = new Nexus.Piano('#app-container');
var sequencer = new Nexus.Sequencer('#app-container', {
 'size': [600,200],
 'mode': 'toggle',
 'rows': 8,
 'columns': 16
})

for (var i = 0; i < 8; i++){
  sequencer.next();
};

//piano.on('change',function(v) {
//  console.log(v);
//})

sequencer.on('step',function(v) {
  console.log(v);
})
