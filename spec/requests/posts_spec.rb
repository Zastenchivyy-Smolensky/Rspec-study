require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get index_path
      expect(response).to have_http_status :ok
      expect(response.body).to include "一覧画面"
    end
  end

  describe "#new" do
    it "正常にレスポンスが返すこと" do
      get new_path
      expect(response).to have_http_status :ok
      expect(response.body).to include "新規登録"
    end
  end

  describe "POST /posts #create"
  it "無効な値だと投稿できない" do
    expect{
      post posts_path, params: {post: {title:""}}
    }.to_not change(Post, :count)
  end

  context "有効な値の場合" do
    let(:post_params) {{post:{title:"Example"}}}

    it "投稿されること" do
      expect{
        post posts_path, params: post_params
      }.to change(Post, :count).by 1
    end
    it "users/showにリダイレクト" do
      post posts_path, params: post_params
      post = Post.last
      expect(response).to redirect_to post
    end
    it "flashが表示されること" do
      post posts_path params: post_params
      expect(flash).to be_any
    end
  end
  describe "PATCH /user" do
    let!(:post) { FactoryBot.create(:post) }
    it "タイトルの表示" do
      get edit_post_path(post)
      expect(response.body).to include "編集画面"
    end
    context "無効な値の場合" do
      it "更新できない" do
        patch post_path(post), params: {post: {title:""}}
        post.reload
        expect(post.title).to_not eq ""
      end
      it "更新アクション後にeditにページ表示されていること" do
        get edit_post_path(post)
        patch post_path(post), params: {post:{title: ""}}
        expect(response.body).to include "編集画面"
      end
    end
    context "有効な値の場合" do
      before do
        @title="ok"
        patch post_path(post), params:{post:{title: @title}}
      end

      it "更新できること" do
        post.reload
        expect(post.title).to eq @title
      end
      it "Piost#showにリダイレクトすること" do
        expect(response).to redirect_to post
      end
      it "flashが表示されていること" do
        expect(flash).to be_any
      end
    end
  end
  describe "delete /uses/{id}" do
    let!(:post) {FactoryBot.create(:post)}
    context "adminユーザでログイン済みの場合" do
      it "削除できること" do
        expect{delete post_path(post)}.to change(Post, :count).by -1
      end
    end
  end
end
