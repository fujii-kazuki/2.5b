class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # 検索対象
    @model = params[:model]
    # 検索時入力文字
    @word = params[:word]
    # 検索方法
    @method = params[:method]

    if @model == 'User'
      @records = User.search_for(@word, @method)
    else
      @records = Book.search_for(@word, @method)
    end
  end
end
