function verifynotify(field1, field2, result_id, match_html, nomatch_html) {
	this.field1 = field1;
	this.field2 = field2;
	this.result_id = result_id;
	this.match_html = match_html;
	this.nomatch_html = nomatch_html;

	this.check = function() {
		// Make sure we don't cause an error
		// for browsers that do not support getElementById
		if (!this.result_id) {
			return false;
		}
		if (!document.getElementById) {
			return false;
		}
		r = document.getElementById(this.result_id);
		if (!r) {
			return false;
		}

		if (!this.field1.value)
			r.innerHTML = "";
		else if (this.field1.value == this.field2.value) {
			r.innerHTML = this.match_html;
		} else if (this.field1.value != this.field2.value) {
			r.innerHTML = this.nomatch_html;
		}
	}
}

function verifyInput() {
	verify = new verifynotify();
	verify.field1 = document.myPageForm.newPassword;
	verify.field2 = document.myPageForm.password2;
	verify.result_id = "password_result";
	verify.match_html = "<span style=\"color:blue\">새 비밀번호 일치<\/span>";
	verify.nomatch_html = "<span style=\"color:red\">새 비밀번호 불일치<\/span>";

	// Update the result message
	verify.check();
}

// Multiple onload function created by: Simon Willison
// http://simonwillison.net/2004/May/26/addLoadEvent/
function addLoadEvent(func) {
	var oldonload = window.onload;
	if (typeof window.onload != 'function') {
		window.onload = func;
	} else {
		window.onload = function() {
			if (oldonload) {
				oldonload();
			}
			func();
		}
	}
}

addLoadEvent(function() {
	verifyInput();
});