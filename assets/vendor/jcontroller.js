
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


	// function loadComments(post_id, user, content, time){
  //
	// 	$('.comment-div-'+post_id).append(' <div class="comment-result-div'+post_id+'"></div><hr> ');
	// 		$('.comment-result-div'+post_id).append(' <span class="dyey-right dyey-opacity comment-time">'+time+'</span> ');
	// 		$('.comment-result-div'+post_id).append(' <h5 class=" comment-name'+post_id+' dyey-theme-l5"></h5> ');
	// 			$('.comment-name'+post_id).append(' <strong>'+user+'</strong> ');
	// 		$('.comment-result-div'+post_id).append(' <p class="comment-text">'+content+'</p>');
  //
	// 		console.log("loaded");
	// }
