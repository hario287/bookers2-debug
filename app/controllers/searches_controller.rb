class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
      # 検索モデル→params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
      # 検索方法→params[:search]
      # 検索ワード→params[:word]
    # if文を使い、検索モデルUserorBookで条件分岐
    # looksメソッドを使い、検索内容を取得し、変数に代入
    end
  end
end
