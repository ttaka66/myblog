class LoginController < ApplicationController
	# ログインボタンのクリック時に実行されるアクション
	def auth
		# 入力処理に従って認証処理を実行
		mem = Member.authenticate(params[:name], params[:password])
		# 成功した場合はid値をセッションに設定し、もともとの要求ページにリダイレクト
		if mem then
			reset_session
			session[:mem] = mem.id
			redirect_to articles_path
		# 失敗した場合はflash[:referer]を再セットし、ログインページを再描画
		else
			flash.now[:referer] = params[:referer]
			@error = 'ユーザー名/パスワードがまちがっています。'
			render 'index'
		end
	end
end
