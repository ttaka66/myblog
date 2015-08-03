class MembersController < ApplicationController
  require 'kconv'
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_logined, only: [:new, :create]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  def result
    @mem = Member.find_by(name: params[:search])
    @articles = @mem.articles
    @other = true

    page_size = 5 # ページ当たりの件数
    @page = params[:page] == nil ? 1 : params[:page].to_i # ページ番号
    page_num = @page - 1 # sql用ページ番号
    @articles = Article.where(member_id: @mem.id).order(created_at: :desc).
    limit(page_size).offset(page_num * page_size)
    cnt = Article.where(member_id: @mem.id).count # 記事カウント
    @page_last = (cnt.to_f / 5).ceil # ページ数切り上げ

    @articles5 = Article.where(member_id: @mem.id).order(created_at: :desc).
        limit(5)
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
    render layout: 'member_new'
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to controller: :login, action: :index, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, layout: 'member_new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    # 写真ファイルを更新する場合？
    if params[:photo]
      file = params[:photo] # 画像ファイル取得
      name = file.original_filename #画像ファイル名取得
      perms = ['.jpg', '.jpeg', '.gif', '.png']
      # ファイル検証
      if !perms.include?(File.extname(name).downcase)
        flash.now['result'] = 'アップロードできるのは画像ファイルのみです。'
      elsif file.size > 1.megabyte
        flash.now['result'] = 'ファイルのサイズは1MBまでです。'
      else
        # ファイル削除機能未実装
        # mem1 = Member.find(session[:mem])
        # pastphoto = mem1.photo.to_s
        # pastname = "#{@member.id.to_s}-#{@member.created_at.to_s}-#{pastphoto.kconv(Kconv::SJIS, Kconv::UTF8)}"
        newname = "#{@member.id.to_s}-#{@member.created_at.to_s}-#{name.kconv(Kconv::SJIS, Kconv::UTF8)}"
      end
      
      # 写真ファイルが正常の場合(newname変数が存在する)   
      if newname
        respond_to do |format|
          # プロフィール情報をアップデート
          if @member.update(member_params) && @member.update(photo: name)
            # public/docs配下に写真を保存
            File.open("public/docs/#{newname}", 'wb'){ |f| f.write(file.read) }
            # File.delite_file("public/docs/#{pastname}") # ファイル削除機能未実装
            format.html { redirect_to articles_path, notice: 'Member was successfully created.'}            
            format.json { render :show, status: :ok, location: @member }
          else
            format.html { render :edit }
            format.json { render json: @member.errors, status: :unprocessable_entity }
          end
        end
      # 写真ファイルの形式が違うかサイズが大きい場合
      else
        render :edit
      end

    # 写真ファイルを更新しない場合
    else
      respond_to do |format|
        if @member.update(member_params)
          format.html { redirect_to articles_path }
          format.json { render :show, status: :ok, location: @member }
        else
          format.html { render :edit }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :blog_title, :email, :password, :password_confirmation, :birthday, :comefrom, :interest, :agreement )
    end

end
