
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
