
import "phoenix_html"


function myFunction(id) {
	    var x = document.getElementById(id);
	    if (x.className.indexOf("dyey-show") == -1) {
	        x.className += " dyey-show";
	        x.previousElementSibling.className += " dyey-theme-d1";
	    } else {
	        x.className = x.className.replace("dyey-show", "");
	        x.previousElementSibling.className =
	        x.previousElementSibling.className.replace(" dyey-theme-d1", "");
	    }
	}

	function myFunction1(id) {
	    var x = document.getElementById(id);
	    if (x.className.indexOf("dyey-show") == -1) {
	        x.className += " dyey-show";
	    } else {
	        x.className = x.className.replace("dyey-show", "");
	    }

	}

	function myFunction2(id) {
	    var x = document.getElementById(id);
	    if (x.className.indexOf("dyey-show") == -1) {
	        x.className += " dyey-show";
	    } else {

	    }

	}

	// to adjust the navigator when on small screen
	function openNav() {
	    var x = document.getElementById("navOnSmallDevice");
	    if (x.className.indexOf("dyey-show") == -1) {
	        x.className += " dyey-show";
	    } else {
	        x.className = x.className.replace(" dyey-show", "");
	    }
	}
