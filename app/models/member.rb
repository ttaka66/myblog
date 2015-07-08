class Member < ActiveRecord::Base
	has_many :articles
	has_many :comments
	has_many :articles, through: :comments

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

end
