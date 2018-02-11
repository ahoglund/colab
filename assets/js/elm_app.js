const appDiv = document.querySelector('#app-container');
const lab_id = appDiv.getAttribute("data-lab-id");
const elmApp = Elm.Main.embed(appDiv, { jam_id: lab_id });

export default elmApp;
