class ArticlesController < ApplicationController
  # 文字列の形式を変更するメソッド
  require 'kconv'
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_article5, only: [:index, :show, :edit]

  # GET /articles
  # GET /articles.json
  def index
    page_size = 5 # ページ当たりの件数
    @page = params[:page] == nil ? 1 : params[:page].to_i # ページ番号
    page_num = @page - 1 # sql用ページ番号
    @articles = Article.where(member_id: session[:mem]).order(created_at: :desc).
    limit(page_size).offset(page_num * page_size)
    cnt = Article.where(member_id: session[:mem]).count # 記事カウント
    @page_last = (cnt.to_f / 5).ceil # ページ数切り上げ

    if ym = params[:ym]
    	# render text: ym +'%'
    	# @articles = Article.where('created_at LIKE ?', '2015-07%').
    	@articles = Article.where('member_id = ? AND created_at LIKE ?',
    	session[:mem], ym +'%').
    	order(created_at: :desc)
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  	page_size = 5 # ページ当たりの件数
    @page = params[:page] == nil ? 1 : params[:page].to_i # ページ番号
    page_num = @page - 1 # sql用ページ番号
    @comments = @article.comments.order(created_at: :desc).
    limit(page_size).offset(page_num * page_size)
    cnt = @article.comments.count # 記事カウント
    @page_last = (cnt.to_f / 5).ceil # ページ数切り上げ
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article[:member_id] = session[:mem]
    @articles5 = Article.where(member_id: session[:mem]).order(created_at: :desc).
        limit(5)
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_process
    # photoファイルを取得
    @photo = params[:photo]
    # ファイルのベース名(パスを除いた部分)を取得
    # name = file.original_filename
    # # 許可する拡張子を定義
    # perms = ['.jpg', '.jpeg', '.gif', '.ping']
    # # 配列permsにアップロードファイルは拡張子に合致するものがあるか
    # if !perms.include?(File.extname(name).downcase)
    #   result = 'アップロードできるのは画像ファイルのみです。'
    # # アップロードファイルサイズが1MB以下であるか
    # elsif file.size > 1.megabyte
    #   result = 'ファイルサイズは1MBまでです。'
    
    # else
    # # ファイル名をUTF→Shift-JISにエンコード
    # name = name.kconv(Kconv::SJIS, Kconv::UTF8)

    # # /public/docフォルダ配下にアップロードファイルを保存
    # File.open("public/doc/#{name}", 'wb') { |f| f.write(file.read) }
    # result = "#{name.toutf8}をアップロードしました。"

    # end

    # render text: result

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:member_id, :title, :article)
    end

  def set_article5
      @articles5 = Article.where(member_id: @mem).order(created_at: :desc).
        limit(5)
  end

end
