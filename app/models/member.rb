class Member < ActiveRecord::Base
	has_many :articles
	has_many :comments

	before_create :pass_key

	# モデル認証メソッド
	def self.authenticate(membername, password)
		mem = find_by(name: membername)
		# DBのpasswordと合致すればmemを返す
		if mem != nil &&
			mem.password == Digest::SHA1.hexdigest(mem.salt + password) then
			mem
		# DBのpasswordと合致しなければ空の変数を返す
		else
			return
		end
	end

	validates :name,
		presence: { message: 'は必須です'},
		uniqueness: { allow_blank: true, message: '%{value}はすでに存在します' }
	validates :password,
		presence: { message: 'は必須です'},
		length: { minimum: 6, message: 'は%{count}桁でなければなりません'},
		confirmation: { message: 'が一致していません'}
	validates :agreement,
		acceptance: { on: :create, message: 'をチェックしてください' }

# DB格納前のフック
  # saltと暗号化されたパスワードを生成
  def pass_key
    self.salt = Member.new_salt
    self.password = Member.crypt_password( self.salt, self.password )
  end
  
  private
  
  # パスワードを暗号化する
  def self.crypt_password( salt, password)
    Digest::SHA1.hexdigest( salt + password )
  end
  
  # パスワード暗号化のためのsalt生成
  def self.new_salt
    s = rand.to_s.tr('+', '.')
    s[0, if s.size > 32 then 32 else s.size end]
  end

end
