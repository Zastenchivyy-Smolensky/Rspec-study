require 'rails_helper'
 
RSpec.describe "Post", type: :system do
  before do
    driven_by(:rack_test)
  end
 
  describe 'root' do
    it 'root_pathへのリンクが2つ、help, about, contactへのリンクが表示されていること' do
      visit index_path
      link_to_root = page.find_all("a[href=\"#{index_path}\"]")
 
      expect(link_to_root.size).to eq 0
      expect(page).to have_link '新規ページ', href: new_path
    end
  end
end