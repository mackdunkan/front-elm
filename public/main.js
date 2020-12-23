// Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
// https://guide.elm-lang.org/interop/flags.html


var storedState = localStorage.getItem('lang-app-save');
console.log("Retrieved state: ", storedState);
var startingState = storedState ? JSON.parse(storedState) : null;


var flags = startingState

// Start our Elm application
var app = Elm.Main.init({ flags: flags })

app.ports.storeLang.subscribe(function(lang) {

    var langJson = JSON.stringify(lang);
    localStorage.setItem('lang-app-save', langJson);
    console.log("Saved state: ", langJson);
});
// Ports go here
// https://guide.elm-lang.org/interop/ports.html
