init = ->
# Ajax通信に成功したタイミングで実行
	$('.ajaxon').on 'ajax:success', (e,data) ->
		# $(this).css('background', 'red')

		art = $(this).parent().attr('class')
		# $(this).html("<a data-remote="true" href="/articles/#{art}/comments/com">comment(非表示)</a>")

		$("#com#{art}").empty()

		$.each data, ->
			comment = $('<div>').addClass('comment')
			h2 = $('<h2>').append(@cmttitle)
			p = $('<p>').append(@comment)
			comment.append(h2).append(p)

			
	  
	  $("#com#{art}").append(comment)
	  # $(this).removeClass
	  # $(this).addClass('ajaxoff')


	# $('body').on('click', '.vanish', function(){
 #         	$(this).remove();
 #         }


	# $('.ajaxoff').on 'ajax:success', (e,data) ->
	#   $("#com#{art}").empty()
	  
	#   $(this).removeClass
	#   $(this).addClass('ajaxon')


# ページロード時にinit関数を実行
$(document).ready(init)
$(document).on('page:change', init)
