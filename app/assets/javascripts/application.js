// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .


var $nextQuestion;
var $prevQuestion;
var $createTeamBtn;

$(document).ready(function () {

	 $('.slider').bxSlider({
		  pager: false,
		  touchEnabled: false,
		  infiniteLoop: false
	 });

	 setupVars();
	 setupPrevButton();
	 setupNextButton();

	 setupCreateBtn();
});


function setupVars() {
	 $prevQuestion = $('.prev-question');
	 $nextQuestion = $('.next-question');
	 $createTeamBtn = $('#create-team');
}

function setupPrevButton() {
	 $prevQuestion.click(function () {
		  $('.bx-prev').click();
	 })
}

function setupNextButton() {
	 $nextQuestion.click(function () {
		  $('.bx-next').click();
	 })
}

function setupCreateBtn() {
	 $createTeamBtn.click(function () {
		  $('.bx-next').click();
	 })
}

function requestToWs(method, url, quantity, callback) {

	 $.ajax({
		  url: url,
		  context: document.body,
		  type: method,
		  data: {
				quantity: quantity
		  }
	 }).done(function (data) {
		  if (data.response == 'success')
				callback;
	 });
}