require "rails_helper"
RSpec.describe Post, type: :model do
    let(:post) {Post.new(title:"Example")}

    it "postが有効である" do
        expect(post).to be_valid
    end
    it "titleが必須であること" do
        post.title = ""
        expect(post).to_not be_valid
    end
    it 'nameは50文字以内であること' do
        post.title = 'a' * 51
        expect(post).to_not be_valid
    end 
    it "titleは重複して投稿しないこと" do
        duplicate_post = post.dup
        post.save
        expect(duplicate_post).to_not be_valid
    end
end