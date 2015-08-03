class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_logined

  private

  # 認証済みかどうかを判定するcheck_loginedフィルタを定義
  def check_logined
    # セッション情報:mem(id値)が存在するか
    if session[:mem] then
      # 存在する場合はmembersテーブルを検索し、ユーザー情報を取得
      begin
        @mem = Member.find(session[:mem])
        
      # ユーザー情報が存在しない場合は不正ユーザーとみなし、セッションを破棄
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end

    # ユーザー情報を取得できなかった場合にはログインページ(login#indexへ)
    unless @mem
      flash[:referer] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end
end
