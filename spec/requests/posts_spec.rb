require 'rails_helper'

RSpec.describe "Posts", type: :request do
 describe "#index" do
  it "正常にレスポンスを返すこと" do
    get static_pages_index_path
    expect(response).to have_http_status :ok
  end
  it "タイトルが表示される" do
    get static_pages_index_path
    expect(response.body).to include "投稿一覧"
  end
  
 end
end
