# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#category_search').click　->
		cate = $('[name=category]').val();
		$(location).attr("href", window.location.pathname + "?category=" + cate);

